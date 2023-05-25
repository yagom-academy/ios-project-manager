//
//  ProjectManager - TodoViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class TodoViewController: UIViewController, TaskCollectionViewController {
    let mode: WorkState = .todo
    private lazy var collectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: collectionViewLayout())
    lazy var viewModel: any CollectionViewModel = TodoCollectionViewModel(
        collectionView: collectionView,
        cellReuseIdentifier: TaskCell.identifier
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRootView()
        configureCollectionViewLayout()
        configureCollectionView()
    }
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { _, layoutEnvironment in
            var config = UICollectionLayoutListConfiguration(appearance: .grouped)
            config.headerMode = .supplementary
            config.trailingSwipeActionsConfigurationProvider = { [weak self] indexPath in
                guard let self,
                      let task = self.viewModel.task(at: indexPath) else {
                    return UISwipeActionsConfiguration()
                }
                
                let actionHandler: UIContextualAction.Handler = { action, view, completion in
                    self.viewModel.remove(task)
                    completion(true)
                    self.viewModel.updateTask(id: task.id)
                }
                
                let action = UIContextualAction(
                    style: .destructive,
                    title: "Delete",
                    handler: actionHandler
                )
                
                return UISwipeActionsConfiguration(actions: [action])
            }
            
            let section = NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
            section.interGroupSpacing = 10

            return section
        }

        return layout
    }
    
    private func configureRootView() {
        view.backgroundColor = .systemGray4
        view.addSubview(collectionView)
    }
    
    private func configureCollectionViewLayout() {
        collectionView.register(
            HeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderView.identifier
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let safe = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: safe.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safe.bottomAnchor)
        ])
    }
    
    private func configureCollectionView() {
        collectionView.register(TaskCell.self, forCellWithReuseIdentifier: TaskCell.identifier)
        
        do {
            collectionView.dataSource = try viewModel.makeDataSource() as? UICollectionViewDataSource
        } catch {
            print(error.localizedDescription)
        }
        
        collectionView.delegate = self
    }
}

extension TodoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let task = viewModel.task(at: indexPath)
        let detailViewController = DetailViewController(task: task, mode: .update)
        let mainViewController = self.parent as? MainViewController
        detailViewController.delegate = mainViewController?.mainViewModel
        
        self.present(detailViewController, animated: true)
    }
}

