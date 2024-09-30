//
//  NewMemoViewController.swift
//  UIKitMemoTutorial
//
//  Created by 이종선 on 9/19/24.
//

import UIKit

protocol MemoDelegate: AnyObject {
    func didCreateNewMemo(_ memo: Memo)
    func didUpdateMemo(_ memo: Memo)
}

class MemoFormController: UIViewController {
    
    weak var delegate: MemoDelegate?
    private let memoFormView = MemoFormView()
    private var memo: Memo?
    
    init(memo: Memo? = nil) {
        self.memo = memo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = memoFormView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = memo == nil ? "새 메모" : "메모 편집"
        setupNavigationBar()
        
        if let memo = memo {
            memoFormView.titleTextField.text = memo.title
            memoFormView.contentTextView.text = memo.content
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelMemoCreation))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveMemo))
    }
    
    @objc private func cancelMemoCreation() {
        dismiss(animated: true)
    }
    
    @objc private func saveMemo() {
        guard let title = memoFormView.titleTextField.text, !title.isEmpty,
              let content = memoFormView.contentTextView.text, !content.isEmpty else {
            print("제목과 내용을 모두 입력해주세요.")
            return
        }
        
        if var existingMemo = memo {
            existingMemo.title = title
            existingMemo.content = content
            delegate?.didUpdateMemo(existingMemo)
        } else {
                 let newMemo = Memo(title: title, content: content)
                 delegate?.didCreateNewMemo(newMemo)
             }
        dismiss(animated: true)
    }
}
