//
//  TodoView.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/09

import UIKit

final class TodoListView: UIView {
  private let containerStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.backgroundColor = .systemGray5
    return stackView
  }()
  
  private let infoStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.spacing = 5
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .left
    label.font = .preferredFont(forTextStyle: .largeTitle)
    
    label.setContentHuggingPriority(.required, for: .horizontal)
    return label
  }()
  
  private let listCountLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .systemBackground
    label.textAlignment = .center
    label.font = .preferredFont(forTextStyle: .title3)
    label.layer.cornerRadius = 12
    label.layer.backgroundColor = UIColor.black.cgColor
    label.layer.borderColor = UIColor.black.cgColor
    return label
  }()
  
  private let emptyView: UIView = {
    let view = UIView()
    view.backgroundColor = .systemGray5
    return view
  }()
  
  lazy var todoCollectionView: UICollectionView = {
    let layout = createTodoLayout()
    let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
    collectionView.backgroundColor = .systemGray5
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  
  init(headerName: String) {
    super.init(frame: .zero)
    registerCells()
    configureUI()
    titleLabel.text = headerName
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func createTodoLayout() -> UICollectionViewCompositionalLayout {
    let todoItemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .estimated(1))
    
    let outerGroupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .fractionalHeight(1))
    
    let doItem = NSCollectionLayoutItem(layoutSize: todoItemSize)
    doItem.contentInsets = NSDirectionalEdgeInsets(
      top: 10,
      leading: 0,
      bottom: 10,
      trailing: 0
    )
    
    let outerGroup = NSCollectionLayoutGroup.vertical(
      layoutSize: outerGroupSize,
      subitems: [doItem]
    )
    
    let section = NSCollectionLayoutSection(group: outerGroup)
    let layout = UICollectionViewCompositionalLayout(section: section)
    
    return layout
  }
  
  private func registerCells() {
    todoCollectionView.register(TodoCollectionViewCell.self, forCellWithReuseIdentifier: TodoCollectionViewCell.identifier)
  }
  
  func updateListCount(_ count: Int) {
    listCountLabel.text = count.description
  }
  
  private func configureUI() {
    backgroundColor = .systemGray5
    addSubview(containerStackView)
    infoStackView.addArrangedSubviews([titleLabel, listCountLabel, emptyView])
    containerStackView.addArrangedSubviews([infoStackView, todoCollectionView])
    
    NSLayoutConstraint.activate([
      containerStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      containerStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
      containerStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      containerStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      
      titleLabel.leadingAnchor.constraint(equalTo: infoStackView.leadingAnchor, constant: 10),
      listCountLabel.widthAnchor.constraint(equalTo: listCountLabel.heightAnchor)
    ])
  }
}
