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

// MARK: - MemoFormController
class MemoFormController: UIViewController {
    
    private let memoFormView = MemoFormView()
    weak var delegate: MemoDelegate?
    private var memo: Memo?
    private var selectedCategory: Category = .personal
    
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
        setupCategoryPicker()
        
        if let memo = memo {
            memoFormView.titleTextField.text = memo.title
            memoFormView.contentTextView.text = memo.content
            selectedCategory = memo.category
            updateCategoryPicker()
        }
    }
    
    private func updateCategoryPicker() {
        if let index = Category.allCases.firstIndex(of: selectedCategory) {
            memoFormView.categoryPicker.selectRow(index, inComponent: 0, animated: false)
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelMemoForm))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveMemo))
    }
    
    private func setupCategoryPicker() {
        memoFormView.categoryPicker.dataSource = self
        memoFormView.categoryPicker.delegate = self
    }
    
    
    @objc private func cancelMemoForm() {
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
            existingMemo.category = selectedCategory
            delegate?.didUpdateMemo(existingMemo)
        } else {
            let newMemo = Memo(title: title, content: content, category: selectedCategory)
            delegate?.didCreateNewMemo(newMemo)
        }
        
        dismiss(animated: true)
    }
}

extension MemoFormController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Category.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Category.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = Category.allCases[row]
    }
}
