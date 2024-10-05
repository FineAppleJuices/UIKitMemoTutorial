//
//  MemoService.swift
//  UIKitMemoTutorial
//
//  Created by 이종선 on 10/4/24.
//

import CoreData
import Foundation

class MemoService{
    
    let context: NSManagedObjectContext
    var coreDataManager: CoreDataManager
    
    required init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.context = coreDataManager.mainContext
        self.coreDataManager = coreDataManager
    }
    
    func saveMemo(_ memo: MemoModel) {
        _ = memo.mapToEntityInContext(context)
        coreDataManager.saveContext(context)
    }
    
    func fetchMemos() -> [MemoModel] {
        var memos = [MemoModel]()
        do {
            let fetchRequest: NSFetchRequest<MemoEntity> = MemoEntity.fetchRequest()
            let value = try context.fetch(fetchRequest)
            memos = value.map({ MemoModel.mapFromEntity($0) })
            memos = memos.sorted(by: { $0.createdAt.compare($1.createdAt) == .orderedDescending })
        } catch {
            debugPrint("CoreData Error")
        }
        return memos
    }
    
    func fetchMemoWithId(_ id: String) -> MemoModel? {
        do {
            let fetchRequest: NSFetchRequest<MemoEntity> = MemoEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id = %@", id)
            let memoEntities = try context.fetch(fetchRequest)
            guard let memo = memoEntities.first else {
                return nil
            }
            return MemoModel.mapFromEntity(memo)
        } catch {
            debugPrint("CoreData Error")
            return nil
        }
        
    }
    
    func deleteMemo(_ memo: MemoModel) {
        do {
            let fetchRequest: NSFetchRequest<MemoEntity> = MemoEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id = %@", memo.id)
            let memoEntities = try context.fetch(fetchRequest)
            for memoEntity in memoEntities {
                context.delete(memoEntity)
            }
            coreDataManager.saveContext(context)
        } catch {
            debugPrint("CoreData Error")
        }
    }
    
    func updateMemo(_ updatedMemo: MemoModel) -> Bool {
        do {
            let fetchRequest: NSFetchRequest<MemoEntity> = MemoEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id = %@", updatedMemo.id)
            let memoEntities = try context.fetch(fetchRequest)
            
            guard let memoEntity = memoEntities.first else {
                debugPrint("Memo not found for update")
                return false
            }
            
            memoEntity.title = updatedMemo.title
            memoEntity.content = updatedMemo.content
            memoEntity.category = updatedMemo.category.rawValue
            memoEntity.modifiedAt = Date()
            
            coreDataManager.saveContext(context)
            return true
        } catch {
            debugPrint("CoreData Error: \(error)")
            return false
        }
    }
}


