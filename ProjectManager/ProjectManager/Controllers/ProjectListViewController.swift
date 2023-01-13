//
//  ProjectListViewController.swift
//  ProjectManager
//
//  Created by junho lee on 2023/01/13.
//

import UIKit

class ProjectListViewController: UIViewController {
    private let projectStateCount: Int
    private var collectionViews: [UICollectionView] = []
    private let stackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = Constants.defaultSpacing
        return stackView
    }()

    init?(projectStateCount: Int) {
        guard projectStateCount > 0 else { return nil }
        self.projectStateCount = projectStateCount
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = ProjectColor.viewBackground.color
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        configureCollectionViews()
        configureHierarchy()
    }

    private func configureNavigationItem() {
        navigationItem.title = Constants.programName
    }

    private func configureCollectionViews() {
        (0..<projectStateCount).forEach { _ in
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewLayout())
            collectionViews.append(collectionView)
        }
    }

    private func makeCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.showsSeparators = false
        configuration.backgroundColor = ProjectColor.collectionViewBackground.color
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }

    private func configureHierarchy() {
        collectionViews.forEach { collectionView in
            stackView.addArrangedSubview(collectionView)
        }
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
