//
//  SearchCollectionViewController.swift
//  RecentlyBook
//
//  Created by 전원식 on 5/16/25.
//

import UIKit
import SnapKit

class SearchCollectionViewController: UIViewController {

    var selectedBook: KaKaoBook?
    var bookList: [KaKaoBook] = []
    var recentBooks: [KaKaoBook] {
        RecentlyViewedManager.shared.fetch()
    }

    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()

    // 검색 결과 + 최근 본 책을 보여줄 컬렉션뷰 ui
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 40)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(searchBar)
        view.addSubview(collectionView)

        searchBar.delegate = self

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: "SearchCell")
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        collectionView.register(RecentBookCell.self, forCellWithReuseIdentifier: "RecentBookCell")

        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }

    // 책 검색 api 호출
    func fetchBooks(keyword: String) {
        guard let encoded = keyword.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let url = URL(string: "https://dapi.kakao.com/v3/search/book?query=\(encoded)") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("KakaoAK f7c6bb7a62b9585d4dfb4dc132f782b4", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("에러 : \(error)")
                return
            }

            guard let data = data else { return }

            do {
                let decoded = try JSONDecoder().decode(KaKaoBookResponse.self, from: data)
                self.bookList = decoded.documents
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch {
                print("디코딩 실패: \(error)")
            }
        }.resume()
    }

    func setupConstraints() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// 컬렉션뷰 구성
extension SearchCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, DetailViewControllerDelegate {
    
    // 섹션 수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recentBooks.isEmpty ? 1 : 2
    }

    // 섹션별 아이템 수 반환
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 && !recentBooks.isEmpty ? recentBooks.count : bookList.count
    }

    // 셀 구성
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as? SearchCell else {
            return UICollectionViewCell()
        }
        let book = (numberOfSections(in: collectionView) == 1 || indexPath.section == 1) ? bookList[indexPath.item] : recentBooks[indexPath.item]
        cell.configure(with: book)
        return cell
    }
    
    // 셀 크기 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 32
        let height: CGFloat = (numberOfSections(in: collectionView) == 1 || indexPath.section == 1) ? 80 : 60
        return CGSize(width: width, height: height)
    }

    // 섹션 헤더 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if numberOfSections(in: collectionView) == 1 && bookList.isEmpty {
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: 40)
    }

    // 섹션 헤더 뷰 구성
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderView else {
            return UICollectionReusableView()
        }

        if numberOfSections(in: collectionView) == 1 {
            header.setTitle("검색 결과")
        } else {
            header.setTitle(indexPath.section == 0 ? "최근 본 책" : "검색 결과")
        }

        return header
    }
    
    // 셀 클릭 시 상세 페이지 이동
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let isRecentSection = numberOfSections(in: collectionView) == 2 && indexPath.section == 0

        let book: KaKaoBook

        if isRecentSection {
            guard recentBooks.indices.contains(indexPath.item) else { return }
            book = recentBooks[indexPath.item]
        } else {
            guard bookList.indices.contains(indexPath.item) else { return }
            book = bookList[indexPath.item]
        }

        RecentlyViewedManager.shared.add(book)
        let detailVC = DetailViewController(book: book)
        detailVC.delegate = self
        detailVC.modalPresentationStyle = .pageSheet
        present(detailVC, animated: true)
    }

    // 검색 버튼 클릭 시 검색 실행
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else { return }
        fetchBooks(keyword: query)
        searchBar.resignFirstResponder()
    }
    
    func didDismissDetail() {
        collectionView.reloadData()
    }
}


class HeaderView: UICollectionReusableView {
    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        addSubview(label)
        
        label.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setTitle(_ title: String) {
        label.text = title
    }
}

struct KaKaoBookResponse: Decodable {
    let documents: [KaKaoBook]
}
