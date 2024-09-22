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
        Memo(title: "쇼핑 목록", content: "우유, 빵, 달걀"),
        Memo(title: "할 일", content: "운동가기, 책 반납하기"),
        Memo(title: "회의 안건", content: "프로젝트 진행 상황 공유"),
        Memo(title: "여행 계획", content: "숙소 예약, 관광지 조사")
    ]
    
    override func loadView() {
        view = memoListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memoListView.titleLabel.text = "Fine 메모장"
        
        memoListView.tableView.delegate = self
        memoListView.tableView.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewMemo))
    }
    
    @objc func addNewMemo() {
        let newMemoVC = NewMemoViewController()
        newMemoVC.delegate = self
        let navController = UINavigationController(rootViewController: newMemoVC)
        present(navController, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension MemoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoTableViewCell.identifier, for: indexPath) as? MemoTableViewCell else {
            fatalError("Failed to dequeue MemoTableViewCell")
        }
        
        let memo = memos[indexPath.row]
        cell.configure(with: memo)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MemoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMemo = memos[indexPath.row]
        let detailViewController = MemoDetailViewController(memo: selectedMemo)
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    // UITableView trailingSwipeAction Config
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { [weak self] (action, view, completion) in
              self?.showDeleteConfirmation(for: indexPath)
              completion(true)
          }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
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
}

// MARK: - MemoCreationDelegate 구현
extension MemoListViewController: MemoCreationDelegate {
    func didCreateNewMemo(_ memo: Memo) {
        memos.append(memo)
        self.memoListView.tableView.reloadData()
    }
}
