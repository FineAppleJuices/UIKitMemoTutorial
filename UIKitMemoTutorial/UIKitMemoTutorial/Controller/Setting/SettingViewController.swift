//
//  SettingViewController.swift
//  UIKitMemoTutorial
//
//  Created by 이종선 on 9/30/24.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    let settings = ["알림 설정", "테마 설정", "앱 정보"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "설정"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SettingCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath)
        cell.textLabel?.text = settings[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let settingTitle = settings[indexPath.row]
        var viewController: UIViewController
        
        switch settingTitle {
        case "알림 설정":
            viewController = NotificationSettingsViewController()
        case "테마 설정":
            viewController = ThemeSettingsViewController()
        case "앱 정보":
            viewController = AppInfoViewController()
        default:
            return
        }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
