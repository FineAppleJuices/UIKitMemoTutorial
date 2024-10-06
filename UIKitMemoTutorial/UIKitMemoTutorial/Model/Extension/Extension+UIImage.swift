//
//  Extension+UIImage.swift
//  UIKitMemoTutorial
//
//  Created by 이종선 on 10/6/24.
//

import UIKit

extension UIImage {
    func toData() -> Data? {
        return self.jpegData(compressionQuality: 0.8)
    }
}
