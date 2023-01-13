//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {

    let navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        let navigationItem = UINavigationItem(title: "Project Manager")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: MainViewController.self, action: nil)
        navigationBar.items = [navigationItem]
        navigationBar.barTintColor = UIColor.systemGray6
        return navigationBar
    }()

    let todoTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.text = "TODO"
        return label
    }()

    let todoCountLabel: UILabel = {
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

    let todoEmptyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let todoStackView: UIStackView = {
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

    let doingTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.text = "DOING"
        return label
    }()

    let doingCountLabel: UILabel = {
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

    let doingEmptyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let doingStackView: UIStackView = {
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

    let doneTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.text = "DONE"
        return label
    }()

    let doneCountLabel: UILabel = {
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

    let doneEmptyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let doneStackView: UIStackView = {
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

    let firstDividingLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame.size.width = 8
        view.backgroundColor = .systemGray3
        return view
    }()

    let secondDividingLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame.size.width = 8
        view.backgroundColor = .systemGray3
        return view
    }()

    let todoCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray5
        return collectionView
    }()

    let doingCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray5
        return collectionView
    }()

    let doneCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray5
        return collectionView
    }()

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

    private static func collectionViewLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.showsSeparators = true
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }

//    private func configureDataSource() {
//        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell>
//    }
}

extension MainViewController: UICollectionViewDelegate {

}
