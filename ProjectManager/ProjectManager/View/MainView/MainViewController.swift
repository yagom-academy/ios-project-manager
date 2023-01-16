//
//  ProjectManager - MainViewController.swift
//  Created by 써니쿠키
// 

import UIKit

final class MainViewController: UIViewController {
    
    private let mainViewModel = MainViewModel()
    private let lists: [ListView] = [ListView(), ListView(), ListView()]
    private var dataSources: [DataSource?] = [nil, nil, nil]
    private let listStack = UIStackView(distribution: .fillEqually,
                                        spacing: Default.stackSpacing,
                                        backgroundColor: .systemGray4)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureDataSource()
        takeInitialSnapShot()
        bidingViewModel()
        setupListsDelegator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpListTitles()
        setUpNavigationBar()
        configureHierarchy()
        configureLayout()
    }
    
    private func configureDataSource() {
        Process.allCases.forEach { process in
            dataSources[process.index] = generateDataSource(process: process)
        }
    }
    
    private func generateDataSource(process: Process) -> DataSource {
        return DataSource(tableView: lists[process.index].projectList) { tableView, _, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier)
            as? ListCell
            
            cell?.delegate = self
            cell?.cellViewModel = ListCellViewModel(project: item, process: process)
            cell?.cellViewModel?.setupCell()
            
            return cell
        }
    }
    
    private func takeInitialSnapShot() {
        Process.allCases.forEach { process in
            dataSources[process.index]?.applyInitialSnapShot(mainViewModel.readData(in: process))
        }
    }
    
    private func bidingViewModel() {
        mainViewModel.updateDatas = { [weak self] datas, datasCount in
            self?.dataSources.enumerated().forEach { index, dataSource in
                dataSource?.reload(datas[index]) }
            self?.lists.enumerated().forEach { index, list in
                (list as ListView).setupCountText(datasCount[index]) }
        }
    }
    
    private func setUpListTitles() {
        Process.allCases.forEach { process in
            lists[process.index].setupListTitle(mainViewModel.readTitle(of: process))
        }
    }
}

// MARK: - NavigationBar
extension MainViewController {
    
    private func setUpNavigationBar() {
        let barButton = UIBarButtonItem(image: UIImage(systemName: Default.barButtonImage),
                                        primaryAction: showEditingViewForRegister())
        
        self.navigationController?.navigationBar.topItem?.title = Title.navigationBar
        self.navigationController?.navigationBar.topItem?.setRightBarButton(barButton,
                                                                            animated: true)
    }
    
    private func showEditingViewForRegister() -> UIAction {
        return UIAction { [weak self] _ in
            guard let self = self else { return }
            
            let newProject = self.mainViewModel.newProject
            let editingViewModel = EditingViewModel(editTargetModel: self.mainViewModel,
                                                    project: newProject)
            let editViewController = EditingViewController(viewModel: editingViewModel)
            editViewController.modalPresentationStyle = .formSheet
            
            self.navigationController?.present(editViewController, animated: true)
        }
    }
}

// MARK: - Layout
extension MainViewController {
    
    private func configureHierarchy() {
        lists.forEach { listStack.addArrangedSubview($0) }
        view.addSubview(listStack)
    }
    
    private func configureLayout() {
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
    
    private func setupListsDelegator() {
        lists.forEach {
            $0.setupProjectList(delegator: self, color: .secondarySystemBackground)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
        showEditingView(tableView, didSelectRowAt: indexPath)
    }
    
    private func showEditingView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ListCell,
              let cellViewModel = cell.cellViewModel else { return }
        
        let process = cellViewModel.currentProcess
        let projectToEdit = mainViewModel.readData(in: process)[indexPath.item]
        let editingViewModel = EditingViewModel(editTargetModel: self.mainViewModel,
                                                project: projectToEdit,
                                                isNewProject: false,
                                                process: cellViewModel.currentProcess)
        
        let editViewController = EditingViewController(viewModel: editingViewModel)
        editViewController.modalPresentationStyle = .formSheet
        
        self.navigationController?.present(editViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        guard let cell = tableView.cellForRow(at: indexPath) as? ListCell,
              let cellViewModel = cell.cellViewModel else { return nil }
        
        let process = cellViewModel.currentProcess
        let project = mainViewModel.readData(in: process)[indexPath.item]
        let delete = UIContextualAction(style: .destructive, title: Title.deleteAction) { _, _, _ in
            self.mainViewModel.deleteData(project, in: process)
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

// MARK: - Handling LongPressGesture of Cell
extension MainViewController: ListCellDelegate {
    
    func showPopoverMenu(_ sender: UILongPressGestureRecognizer,
                         using model: ListCellViewModel) {
        guard let project = model.currentProject  else { return }
        
        let menuAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        menuAlert.makePopoverStyle()
        menuAlert.popoverPresentationController?.sourceView = sender.view
        
        let actions = generateMovingActions(about: project, in: model.currentProcess)
        actions.forEach { menuAlert.addAction($0) }
        
        self.present(menuAlert, animated: true)
    }
    
    private func generateMovingActions(about project: Project,
                                       in process: Process) -> [UIAlertAction] {
        return process.movingOption.map { optionTitle, otherOptionProcess in
            UIAlertAction(title: optionTitle, style: .default) { _ in
                self.moveProject(project, from: process, to: otherOptionProcess)
            }
        }
    }
    
    private func moveProject(_ project: Project,
                             from currentProcess: Process,
                             to process: Process) {
        mainViewModel.moveData(project, from: currentProcess, to: process)
    }
}

extension MainViewController {
    
    private enum Default {
        
        static let stackSpacing: CGFloat = 5
        static let barButtonImage = "plus.circle"
    }
    
    private enum Title {
        
        static let deleteAction = "Delete"
        static let navigationBar = "Project Manager"
        
    }
}
