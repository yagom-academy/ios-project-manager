//
//  MainViewController.swift
//  ProjectManager
//
//  Created by summercat on 2023/01/12.
//

import UIKit

final class MainViewController: UIViewController {
    private var mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = LayoutConstant.mainStackSpacing
        
        return stack
    }()
    
    private var todoCollectionView = UICollectionView()
    private var doingCollectionView = UICollectionView()
    private var doneCollectionView = UICollectionView()
    private var todoDataSource: UICollectionViewDiffableDataSource<Status, TaskItem>?
    private var doingDataSource: UICollectionViewDiffableDataSource<Status, TaskItem>?
    private var doneDataSource: UICollectionViewDiffableDataSource<Status, TaskItem>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }

    private func configureNavigationBar() {
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        title = Namespace.NavigationTitle
        
        let plusButton = UIBarButtonItem(image: UIImage(systemName: Namespace.PlusImage),
                                         style: .plain,
                                         target: self,
                                         action: nil)
        navigationItem.rightBarButtonItem = plusButton
    }
    
    private func configureMainStackView() {
        view.addSubview(mainStackView)
        [todoCollectionView, doingCollectionView, doneCollectionView].forEach {
            configureCollectionView(collectionView: $0)
            mainStackView.addArrangedSubview($0)
        }
    }

    // 컬렉션뷰가 다 똑같이 생겼으니까 함수 하나로 구현
    // 매개변수 인자로 todo/doing/done 받으면 될듯
    private func configureCollectionView(collectionView: UICollectionView) {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout.list(using: config)
    }
}

extension MainViewController {
    enum Namespace {
        static let NavigationTitle = "Project Manager"
        static let PlusImage = "plus"
    }
    
    enum LayoutConstant {
        static let mainStackSpacing = CGFloat(20)
    }
}
