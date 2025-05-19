//
//  RecentBookCell.swift
//  RecentlyBook
//
//  Created by 전원식 on 5/19/25.
//

import UIKit

class RecentBookCell: UICollectionViewCell {
    private let thumbnailImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(thumbnailImageView)
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.clipsToBounds = true
        thumbnailImageView.layer.cornerRadius = 8

        thumbnailImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with book: KaKaoBook) {
        if let url = URL(string: book.thumbnail) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.thumbnailImageView.image = image
                    }
                }
            }.resume()
        }
    }
}
