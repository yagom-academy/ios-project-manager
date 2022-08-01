//
//  HistoryViewController.swift
//  ProjectManager
//  Created by LIMGAUI on 2022/07/26

import UIKit
import Combine

final class HistoryViewController: UIViewController {
  typealias DataSource = UICollectionViewDiffableDataSource<Int, Memento>
  typealias SnapShot = NSDiffableDataSourceSnapshot<Int, Memento>
  
  private var bag = Set<AnyCancellable>()
  private let viewModel = HistoryViewModel()
  
  private lazy var historyCollectionView: UICollectionView = {
    let layout = createTodoLayout()
    let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
    collectionView.register(
      HistoryCollectionViewCell.self,
      forCellWithReuseIdentifier: HistoryCollectionViewCell.identifier
    )
    collectionView.backgroundColor = .systemBackground
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    setDataSource()
    bind()
  }
  
  private func setDataSource() {
    viewModel.historyDataSource = makeDataSource(historyCollectionView)
  }
  
  private func makeDataSource(_ collectionView: UICollectionView) -> DataSource {
    return DataSource(
      collectionView: collectionView) { collectionView, indexPath, item in
        let cell = collectionView.dequeueReusableCell(
          withReuseIdentifier: HistoryCollectionViewCell.identifier,
          for: indexPath) as? HistoryCollectionViewCell
        cell?.updateUIDate(item)
        return cell
      }
  }
  
  private func bind() {
    viewModel.historyList
      .sink { [weak self] mementos in
        guard let self = self,
              let historyDataSource = self.viewModel.historyDataSource else { return }
        self.viewModel.applySnapShot(mementos.reversed(), dataSource: historyDataSource)
      }
      .store(in: &bag)
  }
  
  private func createTodoLayout() -> UICollectionViewCompositionalLayout {
    let todoItemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .fractionalHeight(1))
    
    let doItem = NSCollectionLayoutItem(layoutSize: todoItemSize)
    doItem.contentInsets = NSDirectionalEdgeInsets(
      top: 10,
      leading: 0,
      bottom: 10,
      trailing: 0
    )
    
    let outerGroupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .fractionalHeight(0.2))
    
    let outerGroup = NSCollectionLayoutGroup.vertical(
      layoutSize: outerGroupSize,
      subitems: [doItem]
    )
    
    let section = NSCollectionLayoutSection(group: outerGroup)
    let layout = UICollectionViewCompositionalLayout(section: section)
    
    return layout
  }
  
  private func configureUI() {
    view.addSubview(historyCollectionView)
    
    NSLayoutConstraint.activate([
      historyCollectionView.topAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.topAnchor,
        constant: 20
      ),
      historyCollectionView.bottomAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.bottomAnchor,
        constant: -20
      ),
      historyCollectionView.leadingAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.leadingAnchor,
        constant: 10
      ),
      historyCollectionView.trailingAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.trailingAnchor,
        constant: -10
      )
    ])
  }
}
