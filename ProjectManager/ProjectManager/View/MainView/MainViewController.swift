//
//  ProjectManager - MainViewController.swift
//  Created by 써니쿠키
// 

import UIKit

final class MainViewController: UIViewController {
    
    private let mainViewModel = MainViewModel()
    private let listViews: [ListView] = [ListView(), ListView(), ListView()]
    private var dataSources: [DataSource?] = [nil, nil, nil]
    private let listStackView = UIStackView(distribution: .fillEqually,
                                            spacing: Default.stackSpacing,
                                            backgroundColor: .systemGray4)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureDataSource()
        takeInitialSnapShot()
        bidingViewModel()
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
    
    private func generateDataSource(in state: ProjectState) -> DataSource {
        let tableViewOfState = listViews[state.index].projectTableView
        
        return DataSource(tableView: tableViewOfState) { tableView, _, project in
            let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier)
            as? ListCell
            
            cell?.setupViewModel(ProjectViewModel(project: project, state: state))
            
            return cell
        }
    }
    
    private func takeInitialSnapShot() {
        ProjectState.allCases.forEach { state in
            let projects = mainViewModel.fetchProjects(of: state)
            dataSources[state.index]?.applyInitialSnapShot(projects)
                
        }
    }
    
    private func bidingViewModel() {
        mainViewModel.update = { [weak self] projectsGroup, numberOfProject in
            self?.dataSources.enumerated().forEach { state, dataSource in
                dataSource?.reload(projectsGroup[state])
            }
            self?.listViews.enumerated().forEach { state, listView in
                (listView as ListView).setupCountText(numberOfProject[state])
            }
        }
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
        let barButton = UIBarButtonItem(image: UIImage(systemName: Default.barButtonImage),
                                        primaryAction: showEditingViewForRegister())
        
        self.navigationController?.navigationBar.topItem?.title = Title.navigationBar
        self.navigationController?.navigationBar.topItem?.setRightBarButton(barButton,
                                                                            animated: true)
    }
    
    private func showEditingViewForRegister() -> UIAction {
        return UIAction { [weak self] _ in
            guard let self = self else { return }
            
            let newProject = self.mainViewModel.generateNewProject()
            let projectViewModel = ProjectViewModel(project: newProject, state: .todo)
            let editViewController = EditingViewController(projectViewModel: projectViewModel,
                                                           editMode: .editable)
            editViewController.modalPresentationStyle = .formSheet
            
            self.navigationController?.present(editViewController, animated: true)
        }
    }
}

// MARK: - Layout
extension MainViewController {
    
    private func configureHierarchy() {
        listViews.forEach { listStackView.addArrangedSubview($0) }
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
        listViews.forEach {
            $0.setupProjectList(delegator: self, color: .secondarySystemBackground)
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
        
        let editViewController = EditingViewController(projectViewModel: projectViewModel,
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
        actions.forEach { menuAlert.addAction($0) }
        
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
