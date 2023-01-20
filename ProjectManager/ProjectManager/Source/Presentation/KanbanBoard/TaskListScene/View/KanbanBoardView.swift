//
//  KanbanBoardView.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/19.
//

import UIKit

import RxCocoa

final class KanbanBoardView: UICollectionView {
    private let layout: UICollectionViewLayout = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }()
    
    init() {
        super.init(frame: .zero, collectionViewLayout: layout)
        register(KanbanBoardCell.self, forCellWithReuseIdentifier: KanbanBoardCell.reuseIdentifier)
        isScrollEnabled = false
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
