//
//  DetailView.swift
//  RecentlyBook
//
//  Created by 전원식 on 5/14/25.
//

import UIKit
import SnapKit

class DetailView: UIView {

    let thumbnailImageView = UIImageView()
    let titleLabel = UILabel()
    let authorLabel = UILabel()
    let priceLabel = UILabel()
    let contentsLabel = UILabel()
    let closeButton = UIButton(type: .system)
    let putButton = UIButton(type: .system)
    let buttonStack = UIStackView()


    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func setupView() {
        thumbnailImageView.contentMode = .scaleAspectFit
        thumbnailImageView.clipsToBounds = true

        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center

        authorLabel.font = .systemFont(ofSize: 16)
        authorLabel.textColor = .darkGray
        authorLabel.textAlignment = .center

        priceLabel.font = .boldSystemFont(ofSize: 18)
        priceLabel.textColor = .black
        priceLabel.textAlignment = .center

        contentsLabel.font = .systemFont(ofSize: 14)
        contentsLabel.textColor = .darkGray
        contentsLabel.numberOfLines = 0
        contentsLabel.textAlignment = .center

        closeButton.setTitle("X", for: .normal)
        closeButton.backgroundColor = .systemGray5
        closeButton.setTitleColor(.black, for: .normal)
        closeButton.layer.cornerRadius = 24
        closeButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        putButton.setTitle("당기", for: .normal)
        putButton.backgroundColor = .systemGreen
        putButton.setTitleColor(.white, for: .normal)
        putButton.layer.cornerRadius = 24
        putButton.setContentHuggingPriority(.defaultLow, for: .horizontal)

        buttonStack.axis = .horizontal
        buttonStack.spacing = 12
        buttonStack.distribution = .fill
        buttonStack.addArrangedSubview(closeButton)
        buttonStack.addArrangedSubview(putButton)

        closeButton.translatesAutoresizingMaskIntoConstraints = false
        putButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.widthAnchor.constraint(equalTo: putButton.widthAnchor, multiplier: 1.0/3.0).isActive = true

        addSubview(thumbnailImageView)
        addSubview(titleLabel)
        addSubview(authorLabel)
        addSubview(priceLabel)
        addSubview(contentsLabel)
        addSubview(buttonStack)
    }

    private func setupConstraints() {
        thumbnailImageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(24)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(200)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(thumbnailImageView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        authorLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        priceLabel.snp.makeConstraints {
            $0.top.equalTo(authorLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        contentsLabel.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        buttonStack.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(48)
        }
    }
}
