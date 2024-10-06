//
//  MainTabBarController.swift
//  UIKitMemoTutorial
//
//  Created by 이종선 on 9/30/24.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let memoService = MemoService()
        
        let memoListNavController = UINavigationController(rootViewController: MemoListViewController(memoService: memoService))
        memoListNavController.tabBarItem = UITabBarItem(title: "메모", image: UIImage(systemName: "note.text"), tag: 0)
        let memoCollectionController = UINavigationController(rootViewController: MemoCollectionViewController(memoService: memoService))
        memoCollectionController.tabBarItem = UITabBarItem(title: "사진", image: UIImage(systemName: "photo"), tag: 1)
        let settingsNavController = UINavigationController(rootViewController: SettingsViewController(style: .grouped))
        settingsNavController.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "gear"), tag: 2)
               
        
        viewControllers = [memoListNavController, memoCollectionController, settingsNavController]
    }
}

