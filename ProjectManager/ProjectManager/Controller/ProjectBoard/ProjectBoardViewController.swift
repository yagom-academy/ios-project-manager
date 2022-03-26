//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

// MARK: - ProjectBoardViewController
final class ProjectBoardViewController: UIViewController {
    
    // MARK: - Property
    private let projectManager = ProjectManager()
    private let todoViewController = ProjectListViewController(status: .todo)
    private let doingViewController = ProjectListViewController(status: .doing)
    private let doneViewController = ProjectListViewController(status: .done)
    
    // MARK: - UI Property
    private var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        return navigationBar
    }()
    
    private lazy var tableStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [todoViewController.view,
                                                       doingViewController.view,
                                                       doneViewController.view])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .systemGray4
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 7
        return stackView
    }()
    
    private lazy var dataSourceSettingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let cloudImage = UIImage(systemName: "cloud.fill",
                                 withConfiguration: UIImage.SymbolConfiguration(textStyle: .title1))
        button.setImage(cloudImage, for: .normal)
        button.addAction(dataSourceSettingButtonAction, for: .touchUpInside)
        return button
    }()
    
    private lazy var dataSourceSettingButtonAction: UIAction = {
        let action = UIAction { [weak self] _ in
            self?.presentDataSourceConfigView()
        }
        return action
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        self.configureDelegate()
        self.configureSubviews()
        self.configureNavigationItem()
        self.configureNavigationBarLayout()
        self.configureTableStackViewLayout()
        self.configureDataSourceSettingButtonLayout()
        self.projectManager(didChangedDataSource: self.projectManager.projectSourceType ?? .coreData)
    }
     
    // MARK: - Configure View
    private func configureView() {
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = .systemGray6
    }
    
    private func configureSubviews() {
        self.view.addSubview(navigationBar)
        self.view.addSubview(tableStackView)
        self.view.addSubview(dataSourceSettingButton)
    }
    
    private func configureNavigationItem() {
        let navigationItem = UINavigationItem(title: ProjectBoardScene.mainTitle.rawValue)
        let addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                        target: self,
                                        action: #selector(presentProjectCreatorViewController))
        navigationItem.rightBarButtonItem = addButton
        
        navigationBar.items = [navigationItem]
    }
    
    private func configureNavigationBarLayout() {
        let safeArea = self.view.safeAreaLayoutGuide
        navigationBar.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        navigationBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        navigationBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
    }
    
    private func configureTableStackViewLayout() {
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableStackView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            tableStackView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            tableStackView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            tableStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -40)
        ])
    }
    
    private func configureDataSourceSettingButtonLayout() {
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            dataSourceSettingButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            dataSourceSettingButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 7)])
    }
    
    // MARK: - Configure Controller
    private func configureDelegate() {
        self.todoViewController.delegate = self
        self.doingViewController.delegate = self
        self.doneViewController.delegate = self
        
        self.projectManager.delegate = self
        self.navigationBar.delegate = self
    }
    
    // MARK: - Method
    private func updateDataSourceSettingButton(with color: UIColor) {
        let currentImage = self.dataSourceSettingButton.image(for: .normal)
        let newImage =  currentImage?.withTintColor(color, renderingMode: .alwaysOriginal)

        self.dataSourceSettingButton.setImage(newImage, for: .normal)
    }
    
    private func presentDataSourceConfigView() {
        let dataSourceConfigAlertVC = DataSourceConfigViewController(model: self.projectManager)
        dataSourceConfigAlertVC.modalPresentationStyle = .popover
        
        if let popoverPresentationController = dataSourceConfigAlertVC.popoverPresentationController {
            popoverPresentationController.sourceView = self.dataSourceSettingButton
            popoverPresentationController.sourceRect = self.dataSourceSettingButton.frame(forAlignmentRect: .zero)
        }
        self.present(dataSourceConfigAlertVC, animated: false, completion: nil)
    }
    
    // MARK: - @objc Method
    @objc func presentProjectCreatorViewController() {
        let creatorViewController = ProjectViewController(mode: .creation,
                                                          project: nil,
                                                          projectCreationDelegate: self,
                                                          projectEditDelegate: nil)
        creatorViewController.modalPresentationStyle = .formSheet
        present(creatorViewController, animated: false, completion: nil)
    }
}

// MARK: - UINavigationBarDelegate
extension ProjectBoardViewController: UINavigationBarDelegate {
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.topAttached
    }
}

// MARK: - ProjectCreationViewControllerDelegate
extension ProjectBoardViewController: ProjectCreationDelegate {
    
    func createProject(with content: [String : Any]) {
        self.projectManager.create(with: content)
        self.todoViewController.updateView()
    }

}

// MARK: - ProjectListViewControllerDelegate
extension ProjectBoardViewController: ProjectListViewControllerDelegate {
    
    func readProject(of status: Status, completion: @escaping (Result<[Project]?, Error>) -> Void) {
        self.projectManager.readProject(of: status, completion: completion)
    }
    
    func updateProjectStatus(of identifier: String, with status: Status) {
        self.projectManager.updateProjectStatus(of: identifier, with: status)
        self.todoViewController.updateView()
        self.doingViewController.updateView()
        self.doneViewController.updateView()
    }
    
    func updateProject(of identifier: String, with content: [String : Any]) {
        self.projectManager.updateProjectContent(of: identifier, with: content)
        self.todoViewController.updateView()
        self.doingViewController.updateView()
        self.doneViewController.updateView()
    }
    
    func deleteProject(of identifier: String) {
        self.projectManager.delete(of: identifier)
    }
}

// MARK: - ProjectManagerDelegate
extension ProjectBoardViewController: ProjectManagerDelegate {
    
    func projectManager(didChangedDataSource dataSource: DataSourceType) {
        switch dataSource {
        case .inMemory:
            self.updateDataSourceSettingButton(with: .gray)
        case .coreData:
            self.updateDataSourceSettingButton(with: .gray)
        case .firestore:
            self.updateDataSourceSettingButton(with: .blue)
        }
        self.todoViewController.updateView()
        self.doingViewController.updateView()
        self.doneViewController.updateView()
    }
    
    func projectManager(didChangedNetworkStatus with: NetworkStatus) {
        // TODO: - 네트워크 상태 변화에 따른 버튼 이미지 변경
    }
    
}
