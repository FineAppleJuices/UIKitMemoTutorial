//
//  Memo.swift
//  UIKitMemoTutorial
//
//  Created by 이종선 on 9/8/24.
//

import Foundation
import CoreData

struct MemoModel: Identifiable, Equatable {
    let id: String
    var title: String
    var content: String
    let createdAt: Date = Date()
    var modifiedAt: Date?
    var category: Category
}

extension MemoModel {
    func mapToEntityInContext(_ context: NSManagedObjectContext) -> MemoEntity {
        
        let memo: MemoEntity = .init(context: context)
        memo.id = self.id
        memo.title = self.title
        memo.content = self.content
        memo.createdAt = self.createdAt
        if let modifiedAt = self.modifiedAt {
            memo.modifiedAt = modifiedAt
        }
        memo.category = self.category.rawValue
        
        return memo
    }
    
    static func mapFromEntity(_ entity: MemoEntity) -> Self {
        return .init(id: entity.id ,title: entity.title, content: entity.content, modifiedAt: entity.modifiedAt ?? nil, category: Category(rawValue: entity.category) ?? Category.todos)
            
    }
    
}
