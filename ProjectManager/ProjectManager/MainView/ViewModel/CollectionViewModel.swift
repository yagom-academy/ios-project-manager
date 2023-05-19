//
//  CollectionViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/19.
//

import UIKit

final class CollectionViewModel<CellType: UICollectionViewCell & Providable>: NSObject {
    typealias Item = CellType.ProvidedItem
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    
    private weak var collectionView: UICollectionView?
    
    private var dataSource: DataSource?
    private var cellIdentifier: String
    
    init(collectionView: UICollectionView?, cellReuseIdentifier: String) {
        self.collectionView = collectionView
        self.cellIdentifier = cellReuseIdentifier
        super.init()
    }
    
    enum Section {
        case todo
        case doing
        case done
    }
}
