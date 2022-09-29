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
    func historyButtonDidTapped(in viewController: TodoListViewController)
}

final class TodoListViewController: UIViewController {
    weak var delegate: TodoListViewControllerDelegate?
    
    let todoListView: ListView
    let doingListView: ListView
    let doneListView: ListView
    var navigationBar = UINavigationBar()
    
    private let stackView = DefaultStackViewBuilder()
        .useAutoLayout()
        .setAxis(.horizontal)
        .setBackgroundColor(.systemGray3)
        .setSpacing(6)
        .stackView
    
    init(delegate: TodoListViewControllerDelegate) {
        self.delegate = delegate
        self.todoListView = ListView(category: Category.todo,
                                     delegate: delegate)
        self.doingListView = ListView(category: Category.doing,
                                      delegate: delegate)
        self.doneListView = ListView(category: Category.done,
                                     delegate: delegate)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewLifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
        setupNavigationBar()
        setupToolBar()
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
        var statusBarHeight: CGFloat = 0
        statusBarHeight = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0

        navigationBar = UINavigationBar(
            frame: .init(x: 0, y: statusBarHeight,
                         width: view.frame.width,
                         height: statusBarHeight+30)
        )
        navigationBar.isTranslucent = false
        navigationBar.backgroundColor = .systemBackground

        let naviItem = UINavigationItem(title: "Project Manager")
        naviItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonDidTapped)
        )
        naviItem.leftBarButtonItem = UIBarButtonItem(
            title: "History",
            style: .done,
            target: self,
            action: #selector(historyButtonDidTapped)
        )
        navigationBar.items = [naviItem]

        view.addSubview(navigationBar)
    }
    
    private func setupToolBar() {
        let toolBar = UIToolbar(
            frame: .init(x: 0,
                         y: view.frame.height-60,
                         width: view.frame.width,
                         height: 50)
        )
        toolBar.backgroundColor = .systemBackground
        let undoItem = UIBarButtonItem(
            title: "undo",
            style: .plain,
            target: self,
            action: #selector(undoButtonDidTapped)
        )
        let redoItem = UIBarButtonItem(
            title: "redo",
            style: .plain,
            target: self,
            action: #selector(redoButtonDidTapped)
        )
        undoItem.isEnabled = false
        redoItem.isEnabled = false
        toolBar.setItems([undoItem, redoItem], animated: false)
        TodoDataManager.shared.didChangedData.append {
            undoItem.isEnabled = TodoDataManager.shared.canUndo()
            redoItem.isEnabled = TodoDataManager.shared.canRedo()
        }
        view.addSubview(toolBar)
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
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 50
            ),
            stackView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -40
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
        delegate?.historyButtonDidTapped(in: self)
    }
    
    @objc private func undoButtonDidTapped(_ sender: UIBarButtonItem) {
        TodoDataManager.shared.undo()
    }
    
    @objc private func redoButtonDidTapped(_ sender: UIBarButtonItem) {
        TodoDataManager.shared.redo()
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

// MARK: - UIPopoverPresentationControllerDelegate
extension TodoListViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController,
                                   traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}
