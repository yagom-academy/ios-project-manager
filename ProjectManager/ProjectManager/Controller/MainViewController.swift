//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {

    private let navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        let navigationItem = UINavigationItem(title: "Project Manager")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: MainViewController.self, action: nil)
        navigationBar.items = [navigationItem]
        navigationBar.barTintColor = UIColor.systemGray6
        return navigationBar
    }()

    private let todoTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.text = "TODO"
        return label
    }()

    private let todoCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.text = "5"
        label.widthAnchor.constraint(equalTo: label.heightAnchor).isActive = true
        label.layer.masksToBounds = true
        label.backgroundColor = .black
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private let todoEmptyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let todoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.backgroundColor = .systemGray5
        stackView.spacing = 8
        return stackView
    }()

    private let doingTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.text = "DOING"
        return label
    }()

    private let doingCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.text = "2"
        label.widthAnchor.constraint(equalTo: label.heightAnchor).isActive = true
        label.layer.masksToBounds = true
        label.backgroundColor = .black
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private let doingEmptyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let doingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.backgroundColor = .systemGray5
        stackView.spacing = 8
        return stackView
    }()

    private let doneTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.text = "DONE"
        return label
    }()

    private let doneCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.text = "3"
        label.widthAnchor.constraint(equalTo: label.heightAnchor).isActive = true
        label.layer.masksToBounds = true
        label.backgroundColor = .black
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private let doneEmptyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let doneStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.backgroundColor = .systemGray5
        stackView.spacing = 8
        return stackView
    }()

    private let firstDividingLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame.size.width = 8
        view.backgroundColor = .systemGray3
        return view
    }()

    private let secondDividingLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame.size.width = 8
        view.backgroundColor = .systemGray3
        return view
    }()

    private let todoCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray5
        return collectionView
    }()

    private let doingCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray5
        return collectionView
    }()

    private let doneCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray5
        return collectionView
    }()

    private let todoLists: [TodoModel] = [
        TodoModel(title: "hi", body: "bodyasldjaksdjfl;aksdfkadskflasdklfasldkfadkakdakfakfalkdakdfakdfakdlkjfakdjf;lakjfkldajsfkjadkfjakdjflaasdfasfasdfasdasdfasdfasfdasdfaf", date: "11-11-11"),
        TodoModel(title: "bye", body: "dd", date: "22-22-22"),
        TodoModel(title: "asdf", body: "ffff", date: "33-33-33")
    ]

    private var dataSource: UICollectionViewDiffableDataSource<Int, TodoModel.ID>? = nil

    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .systemGray3
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(navigationBar)
        view.addSubview(todoCollectionView)
        view.addSubview(doingCollectionView)
        view.addSubview(doneCollectionView)
        view.addSubview(todoStackView)
        view.addSubview(doingStackView)
        view.addSubview(doneStackView)
        view.addSubview(firstDividingLineView)
        view.addSubview(secondDividingLineView)

        todoCollectionView.delegate = self
        configureDataSource()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        todoCountLabel.layer.cornerRadius = todoCountLabel.frame.width / 2
        doingCountLabel.layer.cornerRadius = doingCountLabel.frame.width / 2
        doneCountLabel.layer.cornerRadius = doneCountLabel.frame.width / 2
        let stackViewWidthSize = (UIScreen.main.bounds.size.width - 16) / 3
        todoStackView.widthAnchor.constraint(equalToConstant: stackViewWidthSize).isActive = true
        doingStackView.widthAnchor.constraint(equalToConstant: stackViewWidthSize).isActive = true
        firstDividingLineView.widthAnchor.constraint(equalToConstant: 8).isActive = true
        secondDividingLineView.widthAnchor.constraint(equalToConstant: 8).isActive = true
        todoEmptyView.setContentCompressionResistancePriority(.defaultHigh + 1, for: .horizontal)
        doingEmptyView.setContentCompressionResistancePriority(.defaultHigh + 1, for: .horizontal)
        doneEmptyView.setContentCompressionResistancePriority(.defaultHigh + 1, for: .horizontal)
        configureSubViews()
    }
    private func configureSubViews() {
        todoStackView.addArrangedSubview(todoTitleLabel)
        todoStackView.addArrangedSubview(todoCountLabel)
        todoStackView.addArrangedSubview(todoEmptyView)
        doingStackView.addArrangedSubview(doingTitleLabel)
        doingStackView.addArrangedSubview(doingCountLabel)
        doingStackView.addArrangedSubview(doingEmptyView)
        doneStackView.addArrangedSubview(doneTitleLabel)
        doneStackView.addArrangedSubview(doneCountLabel)
        doneStackView.addArrangedSubview(doneEmptyView)

        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            todoStackView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            todoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),

            todoCollectionView.topAnchor.constraint(equalTo: todoStackView.bottomAnchor, constant: 1),
            todoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            todoCollectionView.trailingAnchor.constraint(equalTo: todoStackView.trailingAnchor),
            todoCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            firstDividingLineView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            firstDividingLineView.leadingAnchor.constraint(equalTo: todoStackView.trailingAnchor),
            firstDividingLineView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            doingStackView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            doingStackView.leadingAnchor.constraint(equalTo: firstDividingLineView.trailingAnchor),

            doingCollectionView.topAnchor.constraint(equalTo: doingStackView.bottomAnchor, constant: 1),
            doingCollectionView.leadingAnchor.constraint(equalTo: firstDividingLineView.trailingAnchor),
            doingCollectionView.trailingAnchor.constraint(equalTo: doingStackView.trailingAnchor),
            doingCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            secondDividingLineView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            secondDividingLineView.leadingAnchor.constraint(equalTo: doingStackView.trailingAnchor),
            secondDividingLineView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            doneStackView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            doneStackView.leadingAnchor.constraint(equalTo: secondDividingLineView.trailingAnchor),
            doneStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            doneCollectionView.topAnchor.constraint(equalTo: doneStackView.bottomAnchor, constant: 1),
            doneCollectionView.leadingAnchor.constraint(equalTo: secondDividingLineView.trailingAnchor),
            doneCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            doneCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

//    private static func collectionViewLayout() -> UICollectionViewLayout {
//        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
//        configuration.showsSeparators = true
//        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
//        return layout
//    }

    private static var collectionViewLayout: UICollectionViewCompositionalLayout = {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .estimated(10))
        let layoutItem = NSCollectionLayoutItem(layoutSize: layoutSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(10))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                             subitems: [layoutItem])
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.interGroupSpacing = 8
        let compositionalLayout = UICollectionViewCompositionalLayout(section: layoutSection)
        return compositionalLayout
    }()

    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, TodoModel.ID> { [weak self] cell, _, itemIdentifier in
            var contentConfiguration = TodoContentView.Configutation()
            guard let todoModel = self?.todoLists.first(where: { todoModel in
                todoModel.id == itemIdentifier
            }) else {
                cell.contentConfiguration = contentConfiguration
                return
            }

            contentConfiguration.title = todoModel.title
            contentConfiguration.body = todoModel.body
            contentConfiguration.date = todoModel.date
            cell.contentConfiguration = contentConfiguration
        }

        dataSource = UICollectionViewDiffableDataSource<Int, TodoModel.ID>(collectionView: todoCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })

        var snapshot = NSDiffableDataSourceSnapshot<Int, TodoModel.ID>()
        snapshot.appendSections([0])
        snapshot.appendItems(todoLists.map { $0.id }, toSection: 0)
//        snapshot.reloadItems([todoLists[0].id, todoLists[1].id])
        dataSource?.apply(snapshot)
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 100
    }
}
