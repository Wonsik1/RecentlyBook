//
//  SearchCollectionViewController.swift
//  RecentlyBook
//
//  Created by 전원식 on 5/16/25.
//

import UIKit
import SnapKit

class SearchCollectionViewController: UIViewController {
    
    
    let searchBar: UISearchBar = {
       
        let searchBar = UISearchBar()
        
        return searchBar
    }()
    
    
    let searchLabel: UILabel = {
       
        let searchLabel = UILabel()
        searchLabel.text = "검색 결과"
        
        return searchLabel
    }()
    
    
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        view.addSubview(searchLabel)
        view.addSubview(searchBar)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: "SearchCell")
        
        configure()
        
      
    }

func configure() {
    
    
    searchBar.snp.makeConstraints {
          $0.top.equalTo(view.safeAreaLayoutGuide)
          $0.leading.trailing.equalToSuperview()
      }

      searchLabel.snp.makeConstraints {
          $0.top.equalTo(searchBar.snp.bottom).offset(12)
          $0.leading.equalToSuperview().offset(16)
          $0.height.equalTo(20)
      }

      collectionView.snp.makeConstraints {
          $0.top.equalTo(searchLabel.snp.bottom).offset(20)
          $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
      }
  }
}


extension SearchCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as? SearchCell else {
                    return UICollectionViewCell()
                }
              
                return cell
            }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 80)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           let detailVC = DetailViewController()
           detailVC.modalPresentationStyle = .pageSheet
           present(detailVC, animated: true)
       }
}
    
    

