//
//  ThemeSettingsViewController.swift
//  UIKitMemoTutorial
//
//  Created by 이종선 on 9/30/24.
//

import UIKit

class ThemeSettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "테마 설정"
        view.backgroundColor = .systemBackground
        
        let segmentedControl = UISegmentedControl(items: ["라이트", "다크", "시스템"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 2  // 시스템 기본값
        view.addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            segmentedControl.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
}
