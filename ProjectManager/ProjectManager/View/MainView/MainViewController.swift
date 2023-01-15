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
        setUpNavigationBar()
        configureDataSource()
        takeInitialSnapShot()
        setupListsDelegator()
        bidingViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
            
            cell?.cellViewModel.title = item.title ?? ""
            cell?.cellViewModel.description = item.description ?? ""
            cell?.cellViewModel.date = item.date.changeDotFormatString()
            cell?.cellViewModel.process = process

            return cell
        }
    }
    
    func takeInitialSnapShot() {
        dataSources.enumerated().forEach { index, dataSource in
            dataSource?.applyInitialSnapShot(viewModel.datas[index])
        }
    }
    
    func bidingViewModel() {
        viewModel.updateData = { [weak self] process, data, count in
            self?.dataSources[process.index]?.reload(data)
            self?.lists[process.index].countLabel.text = count
        }
    }
    
    func setUpListTitles() {
        lists.enumerated().forEach { index, listView in
            listView.titleLabel.text = viewModel.processTitles[index]
        }
    }
}

// MARK: NavigationBar
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

// MARK: Layout
extension MainViewController {
    
    func configureHierarchy() {
        lists.forEach {
            listStack.addArrangedSubview($0)
        }
        
        view.addSubview(listStack)
    }
    
    func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            listStack.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            listStack.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            listStack.topAnchor.constraint(equalTo: safeArea.topAnchor),
            listStack.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}

// MARK: UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    
    func setupListsDelegator() {
        lists.forEach {
            $0.tableView.delegate = self
            $0.tableView.backgroundColor = .secondarySystemBackground
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        changeBorderColor(tableView, didSelectRowAt: indexPath)
        presentEditingView(tableView, didSelectRowAt: indexPath)
    }
    
    func changeBorderColor(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
        
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.opacity = 0.3
        tableView.cellForRow(at: indexPath)?.selectedBackgroundView = view
    }
    
    func presentEditingView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return  UIView()
    }
}
