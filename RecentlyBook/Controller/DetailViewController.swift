//
//  DetailViewController.swift
//  RecentlyBook
//
//  Created by 전원식 on 5/14/25.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    private let detailView = DetailView()
    private let book: KaKaoBook

    init(book: KaKaoBook) {
        self.book = book
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureWithBook()
        setupActions()
    }

    private func configureWithBook() {
        detailView.titleLabel.text = book.title
        detailView.authorLabel.text = book.authors.joined(separator: ", ")
        detailView.priceLabel.text = "\(book.price)원"
        detailView.contentsLabel.text = book.contents

        if let url = URL(string: book.thumbnail) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.detailView.thumbnailImageView.image = image
                    }
                }
            }.resume()
        }
    }

    private func setupActions() {
        detailView.closeButton.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
        detailView.putButton.addTarget(self, action: #selector(putBook), for: .touchUpInside)
    }

    @objc func closeModal() {
        dismiss(animated: true, completion: nil)
    }

    @objc func putBook() {
        let bookEntity = SavedBook(context: CoreDataManager.shared.context)
        bookEntity.title = book.title
        bookEntity.authors = book.authors.joined(separator: ", ")
        bookEntity.price = Int32(book.price)
        bookEntity.thumbnail = book.thumbnail
        CoreDataManager.shared.saveContext()
        dismiss(animated: true, completion: nil)
    }
}
