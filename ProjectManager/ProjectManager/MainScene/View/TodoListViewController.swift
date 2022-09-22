//
//  ProjectManager - TodoListViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import RealmSwift

protocol TodoListViewControllerDelegate: AnyObject {
    func addButtonDidTapped()
    func cellDidTapped(at index: Int, in category: String)
    func cellDidLongPressed<T: ListCollectionView>(
        in view: T,
        location: (x: Double, y: Double),
        item: Todo?
    )
}

final class TodoListViewController: UIViewController {
    weak var delegate: TodoListViewControllerDelegate?
    
    let todoListView = ListView(category: Category.todo)
    let doingListView = ListView(category: Category.doing)
    let doneListView = ListView(category: Category.done)
    
    private let stackView = DefaultStackViewBuilder()
        .useAutoLayout()
        .setAxis(.horizontal)
        .setBackgroundColor(.systemGray3)
        .setSpacing(6)
        .stackView
    
    // MARK: - ViewLifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
        setupNavigationBar()
        setupListView()
        placeListView()
        adoptCollectionViewDelegate()
        NetworkCheck.shared.startMonitoring(in: self)
    }
    
    // MARK: - Initial Setup
    private func setupInitialView() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonDidTapped)
        )
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "History",
            style: .done,
            target: self,
            action: #selector(historyButtonDidTapped)
        )
    }
    
    private func setupListView() {
        todoListView.translatesAutoresizingMaskIntoConstraints = false
        doingListView.translatesAutoresizingMaskIntoConstraints = false
        doneListView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            todoListView.widthAnchor.constraint(
                equalToConstant: view.bounds.width/3 - 4
            ),
            doingListView.widthAnchor.constraint(
                equalToConstant: view.bounds.width/3 - 4
            ),
            doneListView.widthAnchor.constraint(
                equalToConstant: view.bounds.width/3 - 4
            )
        ])
    }
    
    private func placeListView() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(todoListView)
        stackView.addArrangedSubview(doingListView)
        stackView.addArrangedSubview(doneListView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            stackView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            ),
            stackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            stackView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor
            )
        ])
    }
    
    private func adoptCollectionViewDelegate() {
        todoListView.collectionView.delegate = self
        doingListView.collectionView.delegate = self
        doneListView.collectionView.delegate = self
    }
    
    // MARK: - @objc Method
    @objc private func addButtonDidTapped() {
        delegate?.addButtonDidTapped()
    }
    
    @objc private func historyButtonDidTapped() {
        print(#function)
    }
}

// MARK: - UICollectionViewDelegate
extension TodoListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView {
        case todoListView.collectionView:
            delegate?.cellDidTapped(at: indexPath.row,
                                    in: Category.todo)
        case doingListView.collectionView:
            delegate?.cellDidTapped(at: indexPath.row,
                                    in: Category.doing)
        case doneListView.collectionView:
            delegate?.cellDidTapped(at: indexPath.row,
                                    in: Category.done)
        default:
            return
        }
    }
}
