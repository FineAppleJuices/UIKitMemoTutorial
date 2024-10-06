//
//  MemoEntity+CoreDataProperties.swift
//  UIKitMemoTutorial
//
//  Created by 이종선 on 10/6/24.
//
//

import Foundation
import CoreData


extension MemoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MemoEntity> {
        return NSFetchRequest<MemoEntity>(entityName: "MemoEntity")
    }

    @NSManaged public var category: String
    @NSManaged public var content: String
    @NSManaged public var createdAt: Date
    @NSManaged public var id: String
    @NSManaged public var modifiedAt: Date?
    @NSManaged public var title: String
    @NSManaged public var image: Data?

}

extension MemoEntity : Identifiable {

}
