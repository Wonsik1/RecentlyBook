//
//  SearchCell.swift
//  RecentlyBook
//
//  Created by 전원식 on 5/16/25.
//

import UIKit

class SearchCell: UICollectionViewCell {
    
    private let titleLabel = UILabel()
    private let authorLabel = UILabel()
    private let priceLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(priceLabel)
        
        authorLabel.font = .systemFont(ofSize: 14)
        authorLabel.textColor = .darkGray
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
        
        authorLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
    }
    
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with book: KaKaoBook) {
        titleLabel.text = book.title
        authorLabel.text = book.authors.joined(separator: ", ")
        priceLabel.text = "\(book.price)원"
    }
    
}
