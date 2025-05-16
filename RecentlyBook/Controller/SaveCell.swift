//
//  SaveCell.swift
//  RecentlyBook
//
//  Created by 전원식 on 5/16/25.
//

import UIKit

class SaveCell: UICollectionViewCell {
    
    private let titleLabel = UILabel()
    private let authorLabel = UILabel()
    private let priceLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        
        titleLabel.text = "담은 책"
        titleLabel.textColor = .black
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with book: SavedBook) {
        titleLabel.text = book.title
        authorLabel.text = book.authors
        priceLabel.text = "\(book.price)원"
    }
    
}
