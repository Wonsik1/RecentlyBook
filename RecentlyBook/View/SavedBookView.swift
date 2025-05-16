//
//  SavedBookView.swift
//  RecentlyBook
//
//  Created by 전원식 on 5/14/25.
//

import UIKit
import SnapKit

class SavedBookView: UIView {

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
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
        addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide).inset(16)
        }
    }
}
