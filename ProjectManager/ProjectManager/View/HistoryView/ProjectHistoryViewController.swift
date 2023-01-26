//
//  HistoryViewController.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/26.
//

import Foundation
import UIKit

final class ProjectHistoryViewController: UIViewController {
    
    typealias CellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell,
                                                                   ProjectHistory>
    
    private let projectHistoryViewModel: ProjectHistoryViewModel
    private var dataSource: HistoryDataSource?
    
    private let historyListCollectionView: UICollectionView = {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.allowsSelection = false
        collectionView.layer.cornerRadius = 10
        
        return collectionView
    }()

    init(viewModel: ProjectHistoryViewModel) {
        self.projectHistoryViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        applySnapShot()
        configureHierarchy()
        configureLayout()
    }
    
    private func applySnapShot() {
        dataSource?.applySnapShot(projectHistoryViewModel.histories)
    }
    
    private func configureHierarchy() {
        view.addSubview(historyListCollectionView)
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            historyListCollectionView.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                                           constant: 10),
            historyListCollectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                                              constant: -10),
            historyListCollectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                                               constant: 10),
            historyListCollectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
                                                                constant: -10)
        ])
    }
    
    private func generateCellRegistration() -> CellRegistration {
        let cellRegistration = CellRegistration { cell, _, projectHistory in
            var content = UIListContentConfiguration.subtitleCell()
            content.text = self.projectHistoryViewModel.fetchHistoryTitle(projectHistory)
            content.textProperties.font = .preferredFont(forTextStyle: .title3)
            content.secondaryText = self.projectHistoryViewModel.fetchHistoryDate(projectHistory)
            content.secondaryTextProperties.color = .systemGray2
            content.secondaryTextProperties.font = .preferredFont(forTextStyle: .body)
            
            cell.contentConfiguration = content
        }
        
        return cellRegistration
    }
    
    private func configureDataSource() {
        let cellRegistration = generateCellRegistration()
        
        dataSource = HistoryDataSource(collectionView: historyListCollectionView,
                                       cellProvider: { collectionView, indexPath, item in
            
            let cell = collectionView.dequeueConfiguredReusableCell( using: cellRegistration,
                                                                     for: indexPath,
                                                                     item: item)
            
            return cell
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
