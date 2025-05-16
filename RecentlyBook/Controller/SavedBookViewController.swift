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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchSavedBooks()
    }

    private func fetchSavedBooks() {
        let request: NSFetchRequest<SavedBook> = SavedBook.fetchRequest()
        savedBooks = (try? CoreDataManager.shared.context.fetch(request)) ?? []
        savedView.collectionView.reloadData()
    }

    @objc func deleteAll() {
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

    @objc func addBook() {

    }
}

extension SavedBookViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedBooks.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SaveCell", for: indexPath) as? SaveCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: savedBooks[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 80)
    }
}
