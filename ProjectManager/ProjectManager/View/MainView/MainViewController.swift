//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class MainViewController: UIViewController {

    var viewModel = MainViewModel()
    let lists: [ListView] = [ListView(), ListView(), ListView()]
    var dataSources: [DataSource?] = [nil, nil, nil]
    let listStack = UIStackView(distribution: .fillEqually,
                                spacing: 5,
                                backgroundColor: .systemGray4)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureDataSource()
        takeInitialSnapShot()
        setupListsDelegator()
        bidingViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpNavigationBar()
        setUpListTitles()
        configureHierarchy()
        configureLayout()
    }
        
    func configureDataSource() {
        Process.allCases.forEach { process in
            dataSources[process.index] = generateDataSource(process: process)
        }
    }
    
    func generateDataSource(process: Process) -> DataSource {
        return DataSource(tableView: lists[process.index].tableView) { tableView, _, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier)
                as? ListCell
            
            cell?.delegate = self
            cell?.cellViewModel.setupCell(project: item, in: process)

            return cell
        }
    }
    
    func takeInitialSnapShot() {
        dataSources.enumerated().forEach { index, dataSource in
            dataSource?.applyInitialSnapShot(viewModel.datas[index])
        }
    }
    
    func bidingViewModel() {
        viewModel.updateDatas = { [weak self] datas, datasCount in
            self?.dataSources.enumerated().forEach { index, dataSource in
                dataSource?.reload(datas[index]) }
            self?.lists.enumerated().forEach { index, list in
                (list as ListView).countLabel.text = datasCount[index] }
        }
    }
    
    func setUpListTitles() {
        lists.enumerated().forEach { index, listView in
            listView.titleLabel.text = viewModel.processTitles[index]
        }
    }
}

// MARK: - NavigationBar
extension MainViewController {
    
    func setUpNavigationBar() {
        let barButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle"),
                                        primaryAction: touchedUpBarButtonAction())
        
        self.navigationController?.navigationBar.topItem?.title = "Project Manager"
        self.navigationController?.navigationBar.topItem?.setRightBarButton(barButton,
                                                                            animated: true)
    }
    
    func touchedUpBarButtonAction() -> UIAction {
        return UIAction { [weak self] _ in
            guard let self = self else { return }
            
            let newProject = self.viewModel.newProject
            let editingViewModel = EditingViewModel(editTargetModel: self.viewModel,
                                                    project: newProject)
            let editViewController = EditingViewController(viewModel: editingViewModel)
            editViewController.modalPresentationStyle = .formSheet
            
            self.navigationController?.present(editViewController, animated: true)
        }
    }
}

// MARK: - Layout
extension MainViewController {
    
    func configureHierarchy() {
        lists.forEach { listStack.addArrangedSubview($0) }
        view.addSubview(listStack)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            listStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            listStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            listStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            listStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    
    func setupListsDelegator() {
        lists.forEach {
            $0.tableView.delegate = self
            $0.tableView.backgroundColor = .secondarySystemBackground
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
        showEditingView(tableView, didSelectRowAt: indexPath)
    }
    
    func showEditingView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ListCell else { return }
        
        let process = cell.cellViewModel.process
        let projectToEdit = viewModel.datas[process.index][indexPath.item]
        let editingViewModel = EditingViewModel(editTargetModel: self.viewModel,
                                                project: projectToEdit,
                                                isNewProject: false,
                                                process: cell.cellViewModel.process)
    
        let editViewController = EditingViewController(viewModel: editingViewModel)
        editViewController.modalPresentationStyle = .formSheet
        
        self.navigationController?.present(editViewController, animated: true)
        editViewController.viewModel.project = projectToEdit
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        guard let cell = tableView.cellForRow(at: indexPath) as? ListCell else { return nil }
        
        let process = cell.cellViewModel.process
        let project = viewModel.datas[process.index][indexPath.item]
        let delete = UIContextualAction(style: .destructive, title: "delete") { _, _, _ in
            self.viewModel.deleteData(project, in: process)
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

// MARK: - Handling LongPressGesture of Cell
extension MainViewController: ListCellDelegate {

    func showPopoverMenu(_ sender: UILongPressGestureRecognizer, using model: ListCellViewModel) {
        guard let project = model.project  else { return }
        
        let menuAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        menuAlert.makePopoverStyle()
        menuAlert.popoverPresentationController?.sourceView = sender.view
        
        let actions = generateMovingActions(about: project, in: model.process)
        actions.forEach { menuAlert.addAction($0) }
        
        self.present(menuAlert, animated: true)
    }
    
    func generateMovingActions(about project: Project, in process: Process) -> [UIAlertAction] {
        return process.movingOption.map { title, otherProcess in
            UIAlertAction(title: title, style: .default) { _ in
                self.moveProject(project, from: process, to: otherProcess)
            }
        }
    }
    
    func moveProject(_ project: Project, from currentProcess: Process, to process: Process) {
        viewModel.moveData(project, from: currentProcess, to: process)
    }
}
