//
//  Extension+Data.swift
//  UIKitMemoTutorial
//
//  Created by 이종선 on 10/6/24.
//

import UIKit

extension Data {
    func toUIImage() -> UIImage? {
        return UIImage(data: self)
    }
}
