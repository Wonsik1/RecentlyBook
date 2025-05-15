//
//  SavedBookViewController.swift
//  RecentlyBook
//
//  Created by 전원식 on 5/16/25.
//

import UIKit

class SavedBookViewController: UIViewController {
    

    
    private let savecollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let scv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        scv.backgroundColor = .white
        return scv
    }()
    
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

        view.addSubview(savecollectionView)

        savecollectionView.delegate = self
        savecollectionView.dataSource = self
        savecollectionView.register(SaveCell.self, forCellWithReuseIdentifier: "SaveCell")
        
        configure()
        
    }
    
    @objc func deleteAll() {
        
    }
    
    @objc func addBook() {
        
    }
    
    private func configure() {
        


        savecollectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        
    }
}
    
    extension SavedBookViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SaveCell", for: indexPath) as? SaveCell else {
                return UICollectionViewCell()
            }
            return cell
        }
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 5
            
            
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width - 32, height: 80)
        }
    }
    

