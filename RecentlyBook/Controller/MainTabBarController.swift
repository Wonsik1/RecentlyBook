//
//  MainViewController.swift
//  RecentlyBook
//
//  Created by 전원식 on 5/14/25.
//

import UIKit

class MainTabBarController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let searchVC = SearchCollectionViewController()
        searchVC.tabBarItem = UITabBarItem(title: "검색 탭", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        
        let saveBookVC = SavedBookViewController()
        saveBookVC.tabBarItem = UITabBarItem(title: "담은 책 리스트 탭", image: UIImage(systemName: "book"), tag: 1)
        
        viewControllers = [
            UINavigationController(rootViewController: searchVC),
            UINavigationController(rootViewController: saveBookVC)
        ]
    }
    
    
}
