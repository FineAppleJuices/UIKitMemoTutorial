//
//  ViewController.swift
//  UIKitMemoTutorial
//
//  Created by 이종선 on 9/7/24.
//

import UIKit

class ViewController: UITableViewController {
    
    // 샘플 메모 데이터
    var memos: [Memo] = [
        Memo(title: "쇼핑 목록", content: "우유, 빵, 달걀"),
        Memo(title: "할 일", content: "운동가기, 책 반납하기"),
        Memo(title: "회의 안건", content: "프로젝트 진행 상황 공유"),
        Memo(title: "여행 계획", content: "숙소 예약, 관광지 조사")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 테이블 뷰에 기본 셀 등록
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MemoCell")
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoCell", for: indexPath)
        
        let memo = memos[indexPath.row]
        cell.textLabel?.text = memo.title
        cell.detailTextLabel?.text = memo.content
        
        return cell
    }
}
