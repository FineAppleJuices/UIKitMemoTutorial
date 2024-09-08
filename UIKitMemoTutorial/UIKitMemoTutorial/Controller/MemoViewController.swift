//
//  ViewController.swift
//  UIKitMemoTutorial
//
//  Created by 이종선 on 9/7/24.
//

import UIKit

class MemoViewController: UIViewController {
    
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
    }
}

// MARK: - UITableViewDataSource
extension MemoViewController: UITableViewDataSource {
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
extension MemoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("선택된 메모: \(memos[indexPath.row].title)")
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
