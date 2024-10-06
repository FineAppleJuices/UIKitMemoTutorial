//
//  MemoCollectionView.swift
//  UIKitMemoTutorial
//
//  Created by 이종선 on 10/6/24.
//

import UIKit

class MemoCollectionView: UICollectionView {
    private let memoFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        return layout
    }()
    
    init() {
        super.init(frame: .zero, collectionViewLayout: memoFlowLayout)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        backgroundColor = .white
        register(MemoCollectionViewCell.self, forCellWithReuseIdentifier: MemoCollectionViewCell.identifier)
        
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = (screenWidth - 2) / 3 // 3개의 셀과 2개의 간격
        memoFlowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth)
    }
}
