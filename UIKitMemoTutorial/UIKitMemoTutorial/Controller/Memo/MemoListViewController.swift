//
//  ViewController.swift
//  UIKitMemoTutorial
//
//  Created by 이종선 on 9/7/24.
//

import UIKit

class MemoListViewController: UIViewController {
    
    private let memoListView = MemoListView()
    
    // 샘플 메모 데이터 (Model)
    var memos: [Memo] = [
        Memo(title: "회의 준비", content: "프레젠테이션 자료 준비", category: .work),
        Memo(title: "쇼핑 목록", content: "우유, 빵, 계란", category: .personal),
        Memo(title: "새로운 앱 아이디어", content: "AR을 활용한 학습 앱", category: .ideas),
        Memo(title: "운동 계획", content: "주 3회 러닝", category: .todos),
        Memo(title: "프로젝트 마감일", content: "다음 주 금요일까지", category: .work)
    ]
    
    var categorizedMemos: [Category: [Memo]] = [:]
    var categories: [Category] = []
    
    override func loadView() {
        view = memoListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memoListView.titleLabel.text = "Fine 메모장"
        
        memoListView.tableView.delegate = self
        memoListView.tableView.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewMemo))
        
        categorizeMemos()
    }
    
    func categorizeMemos() {
        categorizedMemos = Dictionary(grouping: memos, by: { $0.category })
        categories = categorizedMemos.keys.sorted { $0.rawValue < $1.rawValue }
        memoListView.tableView.reloadData()
    }
    
    @objc func addNewMemo() {
        let newMemoVC = MemoFormController()
        newMemoVC.delegate = self
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
        memos.remove(at: indexPath.row)
        self.memoListView.tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    // Edit Memo
    private func showEditMemo(at indexPath: IndexPath) {
        let category = categories[indexPath.section]
        if let memo = categorizedMemos[category]?[indexPath.row] {
            let memoFormController = MemoFormController(memo: memo)
            memoFormController.delegate = self
            let navController = UINavigationController(rootViewController: memoFormController)
            present(navController, animated: true)
        }
    }
}

// MARK: - MemoCreationDelegate 구현
extension MemoListViewController: MemoDelegate {
    func didCreateNewMemo(_ memo: Memo) {
        if categorizedMemos[memo.category] != nil {
            categorizedMemos[memo.category]?.append(memo)
        } else {
            categorizedMemos[memo.category] = [memo]
            categories.append(memo.category)
            categories.sort { $0.rawValue < $1.rawValue }
        }
        memoListView.tableView.reloadData()
    }
    
    func didUpdateMemo(_ updatedMemo: Memo) {
        for (category, memos) in categorizedMemos {
            if let index = memos.firstIndex(where: { $0.id == updatedMemo.id }) {
                if category == updatedMemo.category {
                    categorizedMemos[category]?[index] = updatedMemo
                } else {
                    categorizedMemos[category]?.remove(at: index)
                    if categorizedMemos[category]?.isEmpty == true {
                        categorizedMemos.removeValue(forKey: category)
                        if let categoryIndex = categories.firstIndex(of: category) {
                            categories.remove(at: categoryIndex)
                        }
                    }
                    if categorizedMemos[updatedMemo.category] != nil {
                        categorizedMemos[updatedMemo.category]?.append(updatedMemo)
                    } else {
                        categorizedMemos[updatedMemo.category] = [updatedMemo]
                        categories.append(updatedMemo.category)
                        categories.sort { $0.rawValue < $1.rawValue }
                    }
                }
                memoListView.tableView.reloadData()
                break
            }
        }
    }
}
