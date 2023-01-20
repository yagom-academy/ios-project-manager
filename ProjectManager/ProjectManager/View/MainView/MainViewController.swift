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
    }
    
    private func configureDataSource() {
        ProjectState.allCases.forEach { state in
            dataSources[state.index] = generateDataSource(in: state)
        }
    }
    
    private func generateDataSource(in state: ProjectState) -> DataSource {
        let tableViewOfState = listViews[state.index].projectTableView
        
        return DataSource(tableView: tableViewOfState) { tableView, _, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier)
            as? ListCell
            
            cell?.delegate = self
            cell?.cellViewModel = ListCellViewModel(project: item, state: state)
            cell?.cellViewModel?.setupCell()
            
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
    
    private func showEditingView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ListCell,
              let cellViewModel = cell.cellViewModel,
              let projectToEdit = mainViewModel.fetchProject(index: indexPath.item,
                                                             of: cellViewModel.currentState) else {
            return
        }
  
        let editingViewModel = EditingViewModel(editTargetModel: self.mainViewModel,
                                                project: projectToEdit,
                                                isNewProject: false,
                                                state: cellViewModel.currentState)
        
        let editViewController = EditingViewController(viewModel: editingViewModel)
        editViewController.modalPresentationStyle = .formSheet
        
        self.navigationController?.present(editViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        guard let cell = tableView.cellForRow(at: indexPath) as? ListCell,
              let cellViewModel = cell.cellViewModel,
              let project = mainViewModel.fetchProject(index: indexPath.item,
                                                       of: cellViewModel.currentState) else {
            return nil
        }

        let delete = UIContextualAction(style: .destructive,
                                        title: Title.deleteAction) { _, _, _ in
            self.mainViewModel.delete(project, of: cellViewModel.currentState)
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

// MARK: - Handling LongPressGesture of Cell
extension MainViewController: ListCellDelegate {
    func showPopoverMenu(_ sender: UILongPressGestureRecognizer, using model: ListCellViewModel) {
        guard  let project = model.currentProject,
               sender.state == .began else { return }
        
        let menuAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        menuAlert.makePopoverStyle()
        menuAlert.popoverPresentationController?.sourceView = sender.view
        
        let actions = generateMovingActions(about: project, in: model.currentState)
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
