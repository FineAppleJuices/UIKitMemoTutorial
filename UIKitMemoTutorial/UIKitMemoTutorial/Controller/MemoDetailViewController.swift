//
//  MemoDetailViewController.swift
//  UIKitMemoTutorial
//
//  Created by 이종선 on 9/18/24.
//
import UIKit

class MemoDetailViewController: UIViewController {
    
    private let memo: Memo
    private let memoDetailView: MemoDetailView
    
    init(memo: Memo) {
        self.memo = memo
        self.memoDetailView = MemoDetailView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = memoDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = memo.title
        memoDetailView.configure(with: memo)
    }
}
