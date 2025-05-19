//
//  DetailViewController.swift
//  RecentlyBook
//
//  Created by 전원식 on 5/14/25.
//

import UIKit
import SnapKit

protocol DetailViewControllerDelegate: AnyObject {
    func didDismissDetail()
}

class DetailViewController: UIViewController {
    
    weak var delegate: DetailViewControllerDelegate?
    
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
        RecentlyViewedManager.shared.add(book)
        configureWithBook()
        setupActions()
    }

    private func configureWithBook() { // UI에 책 정보 표시
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

    @objc func putBook() { // 책을 CoreData에 저장
        let bookEntity = SavedBook(context: CoreDataManager.shared.context)
        bookEntity.title = book.title
        bookEntity.authors = book.authors.joined(separator: ", ")
        bookEntity.price = Int32(book.price)
        bookEntity.thumbnail = book.thumbnail
        CoreDataManager.shared.saveContext()
        dismiss(animated: true) {
            self.delegate?.didDismissDetail()
        }
    
    }
    
    @objc func closeModal() {
            dismiss(animated: true) {
                self.delegate?.didDismissDetail()
                
            }
        }
}
