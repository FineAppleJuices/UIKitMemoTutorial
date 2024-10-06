//
//  MemoCollectionViewController.swift
//  UIKitMemoTutorial
//
//  Created by 이종선 on 10/6/24.
//

import UIKit

class MemoCollectionViewController: UIViewController {
    private var memos: [MemoModel] = []
    private lazy var collectionView = MemoCollectionView()
    private var memoService: MemoService!
    
    init(memoService: MemoService!) {
        super.init(nibName: nil, bundle: nil)
        self.memoService = memoService
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(contextObjectsDidChange),
                                               name: NSNotification.Name.NSManagedObjectContextObjectsDidChange,
                                               object: CoreDataManager.shared.mainContext)
    }
    
    @objc func contextObjectsDidChange() {
        loadMemos()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadMemos()
    }
    
    private func setupView() {
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func loadMemos() {
        
        let memos = memoService.fetchMemos()
        self.memos = memos
        collectionView.reloadData()
    }
}

extension MemoCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemoCollectionViewCell.identifier, for: indexPath) as? MemoCollectionViewCell else {
            fatalError("Unable to dequeue MemoCollectionViewCell")
        }
        
        let memo = memos[indexPath.item]
        cell.configure(with: memo)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMemo = memos[indexPath.item]
        let detailViewController = MemoDetailViewController(memo: selectedMemo)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
