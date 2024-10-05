//
//  NewMemoViewController.swift
//  UIKitMemoTutorial
//
//  Created by 이종선 on 9/19/24.
//

import UIKit

// MARK: - MemoFormController
class MemoFormController: UIViewController {
    
    private let memoFormView = MemoFormView()
    private var memo: MemoModel?
    private var selectedCategory: Category = .personal
    private var memoService: MemoService!
    
    init(memo: MemoModel? = nil, memoService: MemoService) {
        self.memo = memo
        self.memoService = memoService
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
            if memoService.updateMemo(existingMemo) {
               print("메모가 성공적으로 업데이트 되었습니다.")
            } else {
                print("메모 업데이트에 실패했습니다.")
            }
            
        } else {
            let newMemo = MemoModel(id: UUID().uuidString, title: title, content: content, category: selectedCategory)
            memoService.saveMemo(newMemo)
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
