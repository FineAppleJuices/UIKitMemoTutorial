//
//  MessageView.swift
//  DelegateSample
//
//  Created by 이종선 on 9/17/24.
//

import UIKit

protocol MessageViewDelegate: AnyObject {
    func messageView(_ messageView: MessageView, didEnterMessage message: String)
}

class MessageView: UIView {
    private let textField: UITextField
    private let sendButton: UIButton
    private let displayLabel: UILabel
    
    weak var delegate: MessageViewDelegate?
    
    override init(frame: CGRect) {
        textField = UITextField()
        sendButton = UIButton(type: .system)
        displayLabel = UILabel()
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter a message"
        
        sendButton.setTitle("Send", for: .normal)
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        
        displayLabel.numberOfLines = 0
        displayLabel.textAlignment = .center
        
        addSubview(textField)
        addSubview(sendButton)
        addSubview(displayLabel)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        displayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            sendButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
            sendButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            displayLabel.topAnchor.constraint(equalTo: sendButton.bottomAnchor, constant: 20),
            displayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            displayLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func sendButtonTapped() {
        guard let message = textField.text, !message.isEmpty else { return }
        delegate?.messageView(self, didEnterMessage: message)
        textField.text = ""
    }
    
    func displayMessage(_ message: String) {
        displayLabel.text = message
    }
}
