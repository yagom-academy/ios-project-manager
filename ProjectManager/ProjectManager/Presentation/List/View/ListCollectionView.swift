//
//  ListCollectionView.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/17.
//

import UIKit

class ListCollectionView: UICollectionView {

    let state: State

    init(state: State, frame: CGRect,  collectionViewLayout: UICollectionViewLayout) {
        self.state = state
        super.init(frame: frame, collectionViewLayout: collectionViewLayout)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
