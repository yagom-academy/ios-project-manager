//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    private let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureCollectionView()
    }
}

extension MainViewController {
    private func createCollectionView() -> UICollectionView {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        configureFlowLayout(flowLayout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(WorkCell.self, forCellWithReuseIdentifier: WorkCell.identifier)
        
        return collectionView
    }
    
    private func configureFlowLayout(_ flowLayout: UICollectionViewFlowLayout) {
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: view.bounds.width / 3, height: view.bounds.height)
        flowLayout.minimumInteritemSpacing = 4
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionHeadersPinToVisibleBounds = true
    }
    
    private func configureCollectionView() {
        let collectionView = createCollectionView()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkCell.identifier, for: indexPath) as? WorkCell else { return UICollectionViewCell() }
        
        cell.configure(title: "제목", body: "설명이 세 줄 이상이면 세 줄 까지만 표시합니다. 설명이 세 줄 이하라면, 설명글의 높이에 맞게 셀의 높이가 맞춰집니다. TODO와 DOING의 기한에 지난 날짜가 있으면 빨간색으로 표시합니다. 셀을 왼쪽으로 스와이프하여 삭제 메뉴를 표시하고, 끝까지 스와이프하거나 삭제 메뉴를 선택하면 해당 할일을 삭제합니다.", deadline: "2023. 5. 18")
        
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate {
    
}
