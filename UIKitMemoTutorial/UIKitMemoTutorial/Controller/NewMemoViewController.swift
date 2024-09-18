//
//  NewMemoViewController.swift
//  UIKitMemoTutorial
//
//  Created by 이종선 on 9/19/24.
//

import UIKit

protocol MemoCreationDelegate: AnyObject {
    func didCreateNewMemo(_ memo: Memo)
}

class NewMemoViewController: UIViewController {
    
    weak var delegate: MemoCreationDelegate?
    private let newMemoView = NewMemoView()
    
    override func loadView() {
        view = newMemoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "새 메모"
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelMemoCreation))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveMemo))
    }
    
    @objc private func cancelMemoCreation() {
        dismiss(animated: true)
    }
    
    @objc private func saveMemo() {
        guard let title = newMemoView.titleTextField.text, !title.isEmpty,
              let content = newMemoView.contentTextView.text, !content.isEmpty else {
            print("제목과 내용을 모두 입력해주세요.")
            return
        }
        
        let newMemo = Memo(title: title, content: content)
        delegate?.didCreateNewMemo(newMemo)
        dismiss(animated: true)
    }
}
