//
//  ListViewController.swift
//  ProjectManager
//
//  Created by karen on 2023/10/03.
//

import UIKit

final class ListViewController: UIViewController {
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: listLayout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let listLayout: UICollectionViewCompositionalLayout = {
        return UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            var listLayout = UICollectionLayoutListConfiguration(appearance: .grouped)
            
            listLayout.headerMode = .supplementary

            let section = NSCollectionLayoutSection.list(using: listLayout, layoutEnvironment: layoutEnvironment)
            
            section.interGroupSpacing = 10
            return section
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setUpConstraints()
        setUpViewController()
    }
    
    private func configureUI() {
        view.addSubview(collectionView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setUpViewController() {
        view.backgroundColor = .systemBackground
    }
}
