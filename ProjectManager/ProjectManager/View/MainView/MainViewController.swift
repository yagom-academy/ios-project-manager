//
//  ProjectManager - MainViewController.swift
//  Created by 써니쿠키
//

import UIKit

final class MainViewController: UIViewController {
    
    private let mainViewModel = MainViewModel()
    private let listViews: [ListView] = [ListView(), ListView(), ListView()]
    private var dataSources: [ProjectDataSource?] = [nil, nil, nil]
    private let listStackView = UIStackView(distribution: .fillEqually,
                                            spacing: Default.stackSpacing,
                                            backgroundColor: .systemGray4)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureDataSource()
        bidingViewModel()
        initialSetup()
        setupListsDelegator()
        setUpListTitles()
        setUpNavigationBar()
        configureHierarchy()
        configureLayout()
        addEditingDoneObserver()
        addLongPressedCellObserver()
    }
    
    private func configureDataSource() {
        ProjectState.allCases.forEach { state in
            dataSources[state.index] = generateDataSource(in: state)
        }
    }
    
    private func generateDataSource(in state: ProjectState) -> ProjectDataSource {
        let tableViewOfState = listViews[state.index].projectTableView
        
        return ProjectDataSource(tableView: tableViewOfState) { tableView, _, project in
            let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier)
            as? ListCell
            
            cell?.setupViewModel(ProjectViewModel(project: project, state: state))
            
            return cell
        }
    }
    
    private func bidingViewModel() {
        mainViewModel.updateProjects = { [weak self] projectsGroup, numberOfProject in
            self?.dataSources.enumerated().forEach { state, dataSource in
                dataSource?.reload(projectsGroup[state])
            }
            self?.listViews.enumerated().forEach { state, listView in
                (listView as ListView).setupCountText(numberOfProject[state])
            }
        }
        
        mainViewModel.updateNetwork = { [weak self] isNetworkConnected in
            DispatchQueue.main.async {
                self?.switchSyncButton(accordingTo: isNetworkConnected)
            }
        }
    }
    
    private func initialSetup() {
        mainViewModel.updateNetwork(mainViewModel.networkIsConnected)
        mainViewModel.initialFetchSavedProjects()
    }

    private func setUpListTitles() {
        ProjectState.allCases.forEach { state in
            listViews[state.index].setupListTitle(mainViewModel.readTitle(of: state))
        }
    }
}

// MARK: - NavigationBar
extension MainViewController {
    
    private func setUpNavigationBar() {
        let syncButton = UIBarButtonItem()
        let plusButton = UIBarButtonItem(image: UIImage(systemName: Default.barButtonImage),
                                         primaryAction: showEditingViewForRegister())
        let historyButton = UIBarButtonItem(title: "History",
                                            image: nil,
                                            primaryAction: showHistory(),
                                            menu: .none)
        
        let navigationBarTopItem = self.navigationController?.navigationBar.topItem
        navigationBarTopItem?.title = Title.navigationBar
        navigationBarTopItem?.setRightBarButtonItems([plusButton, syncButton], animated: true)
        navigationBarTopItem?.setLeftBarButton(historyButton, animated: true)
    }
    
    private func switchSyncButton(accordingTo isNetworkConnected: Bool) {
        let syncButton = UIBarButtonItem()
        
        if isNetworkConnected {
            let syncImage = UIImage(systemName: "arrow.triangle.2.circlepath")
            
            syncButton.primaryAction = syncRemoteData()
            syncButton.image = syncImage
        } else {
            let syncExclamationMarkImage = UIImage(
                systemName: "exclamationmark.arrow.triangle.2.circlepath")?
                .withTintColor(.systemRed, renderingMode: .alwaysOriginal)
            
            syncButton.primaryAction = informOfNoNetwork()
            syncButton.image = syncExclamationMarkImage
        }
        
        let navigationBarTopItem = self.navigationController?.navigationBar.topItem
        navigationBarTopItem?.rightBarButtonItems?[1] = syncButton
    }

    private func showHistory() -> UIAction {
        return UIAction { [weak self] action in
            guard let self = self,
                  let sender = action.sender as? UIBarButtonItem else { return }
            
            let historyViewController = ProjectHistoryViewController(
                viewModel: ProjectHistoryViewModel(histories: self.mainViewModel.projectHistories))
            
            historyViewController.modalPresentationStyle = .popover
            historyViewController.popoverPresentationController?.barButtonItem = sender
            historyViewController.popoverPresentationController?.permittedArrowDirections = .up
            historyViewController.preferredContentSize = CGSize(
                width: (self.view.frame.width) * 0.4,
                height: (self.view.frame.width) * 0.4)
            
            self.navigationController?.present(historyViewController, animated: true)
        }
    }

    private func showEditingViewForRegister() -> UIAction {
        return UIAction { [weak self] _ in
            guard let self = self else { return }
            
            let newProject = self.mainViewModel.generateNewProject()
            let projectViewModel = ProjectViewModel(project: newProject, state: .todo)
            let editViewController = EditingViewController(viewModel: projectViewModel,
                                                           editMode: .editable)
            editViewController.modalPresentationStyle = .formSheet
            
            self.navigationController?.present(editViewController, animated: true)
        }
    }
    
    private func syncRemoteData() -> UIAction {
        return UIAction { [weak self] _ in
            self?.mainViewModel.updateRemoteDataBase()
            
            let alert = UIAlertController(title: "Backup completed",
                                          message: nil,
                                          preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            
            self?.navigationController?.present(alert, animated: true)
        }
    }
    
    private func informOfNoNetwork() -> UIAction {
        return UIAction { [weak self] _ in
            let alert = UIAlertController(title: "Backup failed",
                                          message: "Please check the network connection",
                                          preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Close", style: .default)
            alert.addAction(okAction)
            
            self?.navigationController?.present(alert, animated: true)
        }
    }
}

// MARK: - Layout
extension MainViewController {
    
    private func configureHierarchy() {
        listViews.forEach { listView in
            listStackView.addArrangedSubview(listView)
        }
        
        view.addSubview(listStackView)
    }
    
    private func configureLayout() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            listStackView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            listStackView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            listStackView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            listStackView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    
    private func setupListsDelegator() {
        listViews.forEach { listView in
            listView.setupProjectList(delegator: self, color: .secondarySystemBackground)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
        showEditingView(tableView, didSelectRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        guard let cell = tableView.cellForRow(at: indexPath) as? ListCell,
              let state = cell.projectViewModel?.state,
              let project = mainViewModel.fetchProject(index: indexPath.item,
                                                       of: state) else {
            return nil
        }
        
        let delete = UIContextualAction(style: .destructive,
                                        title: Title.deleteAction) { _, _, _ in
            self.mainViewModel.delete(project, of: state)
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

// MARK: - HandlingEditingView
extension MainViewController {
    private func addEditingDoneObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(editProject),
                                               name: Notification.Name("editingDone"),
                                               object: nil)
    }
    
    @objc private func editProject(notification: Notification) {
        guard let project = notification.userInfo?["project"] as? Project,
              let state = notification.userInfo?["state"] as? ProjectState else { return }
        
        mainViewModel.save(project, in: state)
    }
    
    private func showEditingView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ListCell,
              let state = cell.projectViewModel?.state,
              let projectToEdit = mainViewModel.fetchProject(index: indexPath.item,
                                                             of: state) else {
            return
        }
        
        let projectViewModel = ProjectViewModel(project: projectToEdit,
                                                state: state)
        
        let editViewController = EditingViewController(viewModel: projectViewModel,
                                                       editMode: .readOnly)
        editViewController.modalPresentationStyle = .formSheet
        
        self.navigationController?.present(editViewController, animated: true)
    }
}

// MARK: - Handling LongPressGesture of Cell
extension MainViewController {
    private func addLongPressedCellObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showPopoverMenu),
                                               name: Notification.Name("cellLongPressed"),
                                               object: nil)
    }
    
    @objc private func showPopoverMenu(notification: Notification) {
        guard let project = notification.userInfo?["project"] as? Project,
              let state = notification.userInfo?["state"] as? ProjectState else { return }
        
        let menuAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        menuAlert.makePopoverStyle()
        menuAlert.popoverPresentationController?.sourceView = notification.object as? UIView
        
        let actions = generateMovingActions(about: project, in: state)
        actions.forEach { action in
            menuAlert.addAction(action)
        }
        
        self.present(menuAlert, animated: true)
    }
    
    private func generateMovingActions(about project: Project,
                                       in state: ProjectState) -> [UIAlertAction] {
        let alertActions =  state.movingOption.map { optionTitle, movedState in
            UIAlertAction(title: optionTitle, style: .default) { _ in
                self.moveProject(project, from: state, to: movedState)
            }
        }
        
        return alertActions
    }
    
    private func moveProject(_ project: Project,
                             from currentState: ProjectState,
                             to movedState: ProjectState) {
        mainViewModel.move(project, from: currentState, to: movedState)
    }
}

// MARK: - NameSpace
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
