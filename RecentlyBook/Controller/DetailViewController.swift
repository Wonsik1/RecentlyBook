//
//  DetailViewController.swift
//  RecentlyBook
//
//  Created by 전원식 on 5/14/25.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    private let titleLabel = UILabel()
    private let cancelButton = UIButton(type: .system)
    private let putButton = UIButton(type: .system)
    private let buttonStack = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupBottomButtons()
    }
    
    
    private func setupBottomButtons() {
        
        cancelButton.setTitle("X", for: .normal)
        cancelButton.backgroundColor = .systemGray5
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.layer.cornerRadius = 24
        
        putButton.setTitle("담기", for: .normal)
        putButton.backgroundColor = .systemGreen
        putButton.setTitleColor(.white, for: .normal)
        putButton.layer.cornerRadius = 24
        
        cancelButton.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
//        putButton.addTarget(self, action: #selector(putBook()), for: .touchUpInside)
        
        buttonStack.axis = .horizontal
        buttonStack.spacing = 12
        buttonStack.distribution = .fillEqually
        
        buttonStack.addArrangedSubview(cancelButton)
        buttonStack.addArrangedSubview(putButton)
        view.addSubview(buttonStack)
        
        buttonStack.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(48)
            
            
        }
        
        
        
    }
    
    
    @objc func closeModal() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func putBook() {
        
    }
    
}
