//
//  MemoDetailView.swift
//  UIKitMemoTutorial
//
//  Created by 이종선 on 9/18/24.
//

import UIKit

class MemoDetailView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        
        addSubview(titleLabel)
        addSubview(contentLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            contentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    func configure(with memo: Memo) {
        titleLabel.text = memo.title
        contentLabel.text = memo.content
    }
}
