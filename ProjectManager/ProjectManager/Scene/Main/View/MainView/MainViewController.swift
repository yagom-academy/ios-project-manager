//
//  ProjectManager - ViewController.swift
//  Created by brad, bard.
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    private let mockToDoItemManger = MockToDoItemManager()

    private lazy var toDoListTableView = ProjectTableView(for: .todo, with: mockToDoItemManger)
    private lazy var doingListTableView = ProjectTableView(for: .doing, with: mockToDoItemManger)
    private lazy var doneListTableView = ProjectTableView(for: .done, with: mockToDoItemManger)
    
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = Design.horizontalStackViewSpacing
        stackView.backgroundColor = .systemGray3

        return stackView
    }()
    
    // MARK: - Life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Functions
    
    private func setupUI() {
        setupSubviews()
        setupVerticalStackViewLayout()
        setupView()
        setupDelegates()
//        setupLongTapGesture()
    }
    
    private func setupDelegates() {
        [toDoListTableView, doingListTableView, doneListTableView]
            .forEach { $0.delegate = self }
        
        [toDoListTableView, doingListTableView, doneListTableView]
            .forEach { $0.dataSource = self }
    }
    
    private func setupSubviews() {
        view.addSubview(horizontalStackView)
        
        [toDoListTableView, doingListTableView, doneListTableView]
            .forEach { horizontalStackView.addArrangedSubview($0) }
    }
    
    private func setupVerticalStackViewLayout() {
        guard let navigationBarHeight = navigationController?.navigationBar.frame.height
        else { return }
        
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -navigationBarHeight),
            horizontalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setupView() {
        view.backgroundColor = #colorLiteral(red: 0.9490192533, green: 0.9490200877, blue: 0.9662286639, alpha: 1)
        setupNavigationController()
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.topItem?.title = Design.navigationTitle
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: Design.navigationTitleFontSize, weight: .bold)
        ]
        
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: Design.plusImage),
                                             style: .plain,
                                             target: self,
                                             action: #selector(didPlusButtonTapped))
        
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    // MARK: - objc Functions
    
    @objc private func didCellTappedLong(_ gestureRecognizer: UILongPressGestureRecognizer) {
        guard gestureRecognizer.state == .began else { return }
        
        let alertController = UIAlertController()
        
        let todoAlertAction = UIAlertAction(title: Design.todoAlertActionTitle, style: .default) { _ in
            
        }
        
        let doingAlertAction = UIAlertAction(title: Design.doingAlertActionTitle, style: .default) { _ in
            
        }
        
        let doneAlertAction = UIAlertAction(title: Design.doneAlertActionTitle, style: .default) { _ in
            
        }
        
        alertController.addAction(doingAlertAction)
        alertController.addAction(doneAlertAction)
        
        [toDoListTableView, doingListTableView, doneListTableView]
            .forEach {
                let touchPoint = gestureRecognizer.location(in: $0)
                
                guard let indexPath = $0.indexPathForRow(at: touchPoint),
                      let popoverController = alertController.popoverPresentationController
                else { return }
                
                let cell = $0.cellForRow(at: indexPath)
                
                popoverController.sourceView = cell
                popoverController.sourceRect = cell?.bounds ?? Design.defaultRect
                
                present(alertController, animated: true)
            }
    }
    
    @objc func longPressAction(gestureRecognizer: UILongPressGestureRecognizer) {
        print("Gesture recognized")
    }
    
    @objc private func didPlusButtonTapped() {
        let registrationViewController = RegistrationViewController()
        let navigationController = UINavigationController(rootViewController: registrationViewController)
        registrationViewController.modalPresentationStyle = .formSheet
        
        present(navigationController, animated: true)
    }
    
    // MARK: - Name Space
    
    private enum Design {
        static let horizontalStackViewSpacing: CGFloat = 8
        static let navigationTitle = "Project Manager"
        static let navigationTitleFontSize: CGFloat = 20
        static let plusImage = "plus"
        static let longTapDuration: TimeInterval = 1.5
        static let todoAlertActionTitle = "Move to TODO"
        static let doingAlertActionTitle = "Move to DOING"
        static let doneAlertActionTitle = "Move to DONE"
        static let defaultRect = CGRect(x: 0, y: 0, width: 50, height: 50)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mockToDoItemManger.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProjectTableViewCell.identifier, for: indexPath) as? ProjectTableViewCell
        else { return UITableViewCell() }
        
        cell.configure(data: mockToDoItemManger.content(index: indexPath.row) ?? ToDoItem())
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(didCellTappedLong(_:)))
        lpgr.minimumPressDuration = 2.0
        lpgr.delegate = self
        cell.addGestureRecognizer(lpgr)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let toDoListDetailViewController = ProjectDetailViewController(with: tableView)
        let navigationController = UINavigationController(rootViewController: toDoListDetailViewController)
        
        toDoListDetailViewController.modalPresentationStyle = .formSheet
        toDoListDetailViewController.loadData(of: mockToDoItemManger.content(index: indexPath.row) ?? ToDoItem())
        
        present(navigationController, animated: true)
    }
    
}
