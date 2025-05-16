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

    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()

    let searchLabel: UILabel = {
        let label = UILabel()
        label.text = "검색 결과"
        return label
    }()

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(searchBar)
        view.addSubview(searchLabel)
        view.addSubview(collectionView)

        searchBar.delegate = self

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: "SearchCell")

        setupConstraints()
    }

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

        searchLabel.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(20)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchLabel.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension SearchCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as? SearchCell else {
            return UICollectionViewCell()
        }
        let book = bookList[indexPath.item]
        cell.configure(with: book)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 80)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedBook = bookList[indexPath.item]
        let detailVC = DetailViewController(book: selectedBook)
        detailVC.modalPresentationStyle = .pageSheet
        present(detailVC, animated: true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else { return }
        fetchBooks(keyword: query)
        searchBar.resignFirstResponder()
    }
}

struct KaKaoBookResponse: Decodable {
    let documents: [KaKaoBook]
}
