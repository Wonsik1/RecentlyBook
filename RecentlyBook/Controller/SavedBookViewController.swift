//
//  SavedBookViewController.swift
//  RecentlyBook
//
//  Created by 전원식 on 5/16/25.
//

import UIKit
import CoreData

class SavedBookViewController: UIViewController {

    private let savedView = SavedBookView()
    private var savedBooks: [SavedBook] = []

    override func loadView() {
        view = savedView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "담은 책"

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "전체 삭제",
            style: .plain,
            target: self,
            action: #selector(deleteAll)
        )

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "추가",
            style: .plain,
            target: self,
            action: #selector(addBook)
        )

        savedView.collectionView.delegate = self
        savedView.collectionView.dataSource = self
        savedView.collectionView.register(SaveCell.self, forCellWithReuseIdentifier: "SaveCell")

        fetchSavedBooks()
    }
    
    override func viewWillAppear(_ animated: Bool) { // 화면이 나타날 때마다 데이터 다시 로드
        super.viewWillAppear(animated)
        fetchSavedBooks()
    }

    private func fetchSavedBooks() { // CoreData에서 저장된 책들 불러오기
        let request: NSFetchRequest<SavedBook> = SavedBook.fetchRequest()
        savedBooks = (try? CoreDataManager.shared.context.fetch(request)) ?? []
        savedView.collectionView.reloadData()
    }
    
    private func deleteBook(at indexPath: IndexPath) {  // 특정 책 하나 삭제
        let context = CoreDataManager.shared.context
        let bookToDelete = savedBooks[indexPath.item]
        context.delete(bookToDelete)
        CoreDataManager.shared.saveContext()
        savedBooks.remove(at: indexPath.item)
        savedView.collectionView.deleteItems(at: [indexPath])
    }

    @objc func deleteAll() { // 전체 책 삭제
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = SavedBook.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            CoreDataManager.shared.saveContext()
            savedBooks.removeAll()
            savedView.collectionView.reloadData()
        } catch {
            print("전체 삭제 실패: \(error)")
        }
    }

    @objc func addBook() { // 미구현..

    }
}

// 컬렉션 뷰 설정
extension SavedBookViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedBooks.count
    }
    
    // 셀 개수
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SaveCell", for: indexPath) as? SaveCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: savedBooks[indexPath.item])
        return cell
    }
    
    // 셀 구성
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 80)
    }
    
    // 셀 삭제
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let delete = UIAction(title: "삭제", image: UIImage(systemName: "trash"), attributes: .destructive) { _ in
                self.deleteBook(at: indexPath)
            }
            return UIMenu(title: "", children: [delete])
        }
    }
    
    // 편집 가능한 셀인지 여부
    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
        return true
    }
}
