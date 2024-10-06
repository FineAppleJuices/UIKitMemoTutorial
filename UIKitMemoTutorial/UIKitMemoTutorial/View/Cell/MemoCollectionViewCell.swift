//
//  MemoCollectionViewCell.swift
//  UIKitMemoTutorial
//
//  Created by 이종선 on 10/6/24.
//

import UIKit

class MemoCollectionViewCell: UICollectionViewCell {
    static let identifier = "MemoCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(imageView)
        imageView.frame = contentView.bounds
    }
    
    func configure(with memo: MemoModel) {
        if let imageData = memo.imageData, let image = UIImage(data: imageData) {
            imageView.image = image
        } else {
            imageView.image = UIImage(systemName: "photo")
        }
    }
}
