//
//  ViewController.swift
//  DelegateSample
//
//  Created by 이종선 on 9/17/24.
//

import UIKit

class MessageViewController: UIViewController {
    private let messageView = MessageView()
    private var currentMessage: Message?
    
    override func loadView() {
        view = messageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageView.delegate = self
    }
}

extension MessageViewController: MessageViewDelegate {
    func messageView(_ messageView: MessageView, didEnterMessage message: String) {
        currentMessage = Message(content: message)
        messageView.displayMessage("You entered: \(message)")
    }
}
