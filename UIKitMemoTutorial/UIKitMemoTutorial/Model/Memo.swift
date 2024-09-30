//
//  Memo.swift
//  UIKitMemoTutorial
//
//  Created by 이종선 on 9/8/24.
//

import Foundation

struct Memo: Equatable {
    let id: String = UUID().uuidString
    var title: String
    var content: String
    var category: Category
}
