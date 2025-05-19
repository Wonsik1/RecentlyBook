//
//  PutBookView.swift
//  RecentlyBook
//
//  Created by 전원식 on 5/14/25.
//


import UIKit
import SnapKit

class SearchBookView: UIView {

    let searchBar: UISearchBar = {
        let sb = UISearchBar()
        return sb
    }()

    let searchLabel: UILabel = {
        let label = UILabel()
        label.text = "검색 결과"
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        addSubview(searchBar)
        addSubview(searchLabel)
        addSubview(collectionView)

        searchBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }

        searchLabel.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(20)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchLabel.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}

