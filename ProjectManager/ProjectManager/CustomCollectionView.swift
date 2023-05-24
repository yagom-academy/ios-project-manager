//
//  CustomCollectionView.swift
//  ProjectManager
//
//  Created by Andrew on 2023/05/25.
//
import UIKit

class CustomCollectionView: UICollectionView {
    init() {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        super.init(frame: .zero, collectionViewLayout: layout)
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
