//
//  CustomCollectionView.swift
//  ProjectManager
//
//  Created by Andrew on 2023/05/25.
//
import UIKit

class CustomCollectionView: UICollectionView {
    init() {
        var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
        configuration.headerMode = .supplementary
        configuration.trailingSwipeActionsConfigurationProvider = { (indexPath) in
            let delete = UIContextualAction(style: .normal, title: "Delete") { (action, view, completion) in
                completion(true)
            }
            delete.backgroundColor = .systemRed
            return UISwipeActionsConfiguration(actions: [delete])
        }
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        super.init(frame: .zero, collectionViewLayout: layout)
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
