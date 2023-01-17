//
//  ListView.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/15.
//

import UIKit

final class ListView: UIView {

    typealias Text = Constant.Text
    typealias Style = Constant.Style
    typealias Color = Constant.Color

    private let collectionView: ListCollectionView

    init(state: State, layout: UICollectionViewLayout, frame: CGRect) {
        collectionView = ListCollectionView(state: state,
                                            frame: frame,
                                            collectionViewLayout: layout)
        super.init(frame: frame)
        configureUIComponent()
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUIComponent() {
        backgroundColor = Color.listBackground
        configureViewHierarchy()
        configureLayoutConstraint()
    }

    private func configureViewHierarchy() {
        addSubview(collectionView)
    }

    private func configureLayoutConstraint() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

    func setDataSource(_ dataSource: UICollectionViewDataSource) {
        collectionView.dataSource = dataSource
    }

    func setDelegate(_ delegate: UICollectionViewDelegate) {
        collectionView.delegate = delegate
    }
}
