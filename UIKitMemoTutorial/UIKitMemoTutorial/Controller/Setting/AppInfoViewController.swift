//
//  AppInfoViewController.swift
//  UIKitMemoTutorial
//
//  Created by 이종선 on 9/30/24.
//

import UIKit

class AppInfoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "앱 정보"
        view.backgroundColor = .systemBackground
        
        let infoLabel = UILabel()
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.text = "메모 앱 버전 1.0\n© 2023 Your Company"
        infoLabel.numberOfLines = 0
        infoLabel.textAlignment = .center
        view.addSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
