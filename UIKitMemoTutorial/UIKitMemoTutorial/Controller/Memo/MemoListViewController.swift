//
//  ViewController.swift
//  UIKitMemoTutorial
//
//  Created by 이종선 on 9/7/24.
//

import UIKit

class MemoListViewController: UIViewController {
    
    private let memoListView = MemoListView()
    private var memoService: MemoService!
    
    // 샘플 메모 데이터 (Model)
    var memos: [MemoModel] = []
    var categorizedMemos: [Category: [MemoModel]] = [:]
    var categories: [Category] = []
    
    init(memoService: MemoService) {
        super.init(nibName: nil, bundle: nil)
        self.memoService = memoService
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(contextObjectsDidChange),
                                               name: NSNotification.Name.NSManagedObjectContextObjectsDidChange,
                                               object: CoreDataManager.shared.mainContext)
    }
    
    override func loadView() {
        view = memoListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memoListView.titleLabel.text = "Fine 메모장"
        
        memoListView.tableView.delegate = self
        memoListView.tableView.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewMemo))
        
        fetchMemos()
    }
    
    @objc func contextObjectsDidChange() {
        fetchMemos()
    }
    
    private func fetchMemos() {
        let memos = memoService.fetchMemos()
        self.memos = memos
        categorizeMemos()
    }
    
    func categorizeMemos() {
        categorizedMemos = Dictionary(grouping: memos, by: { $0.category })
        categories = categorizedMemos.keys.sorted { $0.rawValue < $1.rawValue }
        memoListView.tableView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func addNewMemo() {
        let newMemoVC = MemoFormController(memoService: memoService)
        let navController = UINavigationController(rootViewController: newMemoVC)
        present(navController, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension MemoListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = categories[section]
        return categorizedMemos[category]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemoTableViewCell.identifier, for: indexPath) as! MemoTableViewCell
        let category = categories[indexPath.section]
        if let memo = categorizedMemos[category]?[indexPath.row] {
            cell.configure(with: memo)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section].rawValue
    }
}

// MARK: - UITableViewDelegate
extension MemoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let category = categories[indexPath.section]
        if let memo = categorizedMemos[category]?[indexPath.row] {
            let detailViewController = MemoDetailViewController(memo: memo)
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    // UITableView trailingSwipeAction Config
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { [weak self] (action, view, completion) in
            self?.showDeleteConfirmation(for: indexPath)
            completion(true)
        }
        
        let editAction = UIContextualAction(style: .normal, title: "편집") { [weak self] (action, view, completion) in
            self?.showEditMemo(at: indexPath)
            completion(true)
        }
        
        editAction.backgroundColor = .systemBlue
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        return configuration
    }
    
    // Show Action Sheet
    private func showDeleteConfirmation(for indexPath: IndexPath) {
        let alert = UIAlertController(title: "메모 삭제", message: "이 메모를 삭제하시겠습니까?", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { [weak self] _ in
            self?.deleteMemo(at: indexPath)
        }))
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        present(alert, animated: true)
    }
    
    // Delete Memo
    private func deleteMemo(at indexPath: IndexPath) {
        let category = categories[indexPath.section]
        guard var memosInCategory = categorizedMemos[category],
              indexPath.row < memosInCategory.count else {
            print("Invalid index path for deletion")
            return
        }
        
        let memoToDelete = memosInCategory[indexPath.row]
        
        // Remove from categorizedMemos
        memosInCategory.remove(at: indexPath.row)
        categorizedMemos[category] = memosInCategory
        
        // Remove from memos array
        if let index = memos.firstIndex(where: { $0.id == memoToDelete.id }) {
            memos.remove(at: index)
        }
        
        // Delete from Core Data
        memoService.deleteMemo(memoToDelete)
        
        // Update UI
        if memosInCategory.isEmpty {
            categories.remove(at: indexPath.section)
            memoListView.tableView.deleteSections(IndexSet(integer: indexPath.section), with: .fade)
        } else {
            memoListView.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // Edit Memo
    private func showEditMemo(at indexPath: IndexPath) {
        let category = categories[indexPath.section]
        if let memo = categorizedMemos[category]?[indexPath.row] {
            let memoFormController = MemoFormController(memo: memo, memoService: memoService)
            
            let navController = UINavigationController(rootViewController: memoFormController)
            present(navController, animated: true)
        }
    }
}
