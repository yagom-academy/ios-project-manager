//
//  ToDoListCollectionView.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/06.
//

import UIKit

class ListCollectionView: UICollectionView {
    
    // MARK: - Properties
    
    
    // MARK: - Initializers
    
    init() {
//        self.frame = frame
//        self.collectionViewLayout = layout
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Functions
}

final class TodoListCollectionView: ListCollectionView { }

extension TodoListCollectionView: ReuseIdentifiable { }

final class DoingListCollectionView: ListCollectionView { }

extension DoingListCollectionView: ReuseIdentifiable { }

final class DoneListCollectionView: ListCollectionView { }

extension DoneListCollectionView: ReuseIdentifiable { }
