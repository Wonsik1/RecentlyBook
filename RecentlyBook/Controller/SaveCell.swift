//
//  SaveCell.swift
//  RecentlyBook
//
//  Created by 전원식 on 5/16/25.
//

import UIKit
import SnapKit


class SaveCell: UICollectionViewCell {
    
    private let titleLabel = UILabel()
    private let authorLabel = UILabel()
    private let priceLabel = UILabel()     
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func setupUI() {

        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.textColor = .black
        

        authorLabel.font = .systemFont(ofSize: 14)
        authorLabel.textColor = .darkGray
        

        priceLabel.font = .systemFont(ofSize: 14)
        priceLabel.textColor = .darkGray
        

        contentView.addSubview(titleLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(priceLabel)
    }
    
  
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.equalToSuperview().inset(12)
        }
        
        authorLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(12)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(authorLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.bottom.lessThanOrEqualToSuperview().inset(10)
        }
    }
    
   
    func configure(with book: SavedBook) {
        titleLabel.text = book.title
        authorLabel.text = book.authors
        priceLabel.text = "\(book.price)원"
    }
}
