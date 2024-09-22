//
//  NewMemoView.swift
//  UIKitMemoTutorial
//
//  Created by 이종선 on 9/19/24.
//

import UIKit

class MemoFormView: UIView {
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "제목"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let contentTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 5
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        
        addSubview(titleTextField)
        addSubview(contentTextView)
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            contentTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            contentTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            contentTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            contentTextView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

