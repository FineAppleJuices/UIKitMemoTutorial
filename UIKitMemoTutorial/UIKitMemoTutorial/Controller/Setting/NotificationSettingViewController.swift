//
//  NotificationSettingView.swift
//  UIKitMemoTutorial
//
//  Created by 이종선 on 9/30/24.
//

import UIKit

class NotificationSettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "알림 설정"
        view.backgroundColor = .systemBackground
        
        let switchControl = UISwitch()
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(switchControl)
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "알림 켜기"
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            switchControl.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            switchControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: switchControl.leadingAnchor, constant: -20)
        ])
    }
}
