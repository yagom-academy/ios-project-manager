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
            mainStackView.addArrangedSubview($0)
        }
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
