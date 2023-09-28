//
//  ProjectListViewModel.swift
//  ProjectManager
//
//  Created by Erick on 2023/09/22.
//

import UIKit
import Combine

struct ProjectListViewModelAction {
    let showEditProject: (Project?) -> Void
    let showPopAlert: (UIAlertController) -> Void
}

protocol ProjectListViewModelInput {
    func viewDidLoad()
    func handleLongPressGesture(target: UITableView, location: CGPoint)
    func deleteItem(at index: Int)
    func selectItem(at index: Int)
}

protocol ProjectListViewModelOutput {
    var projectsPublisher: Published<[Project]>.Publisher { get }
    var projectCountPublisher: Published<Int>.Publisher { get }
    var navigationTitle: String { get }
}

typealias ProjectListViewModel = ProjectListViewModelInput & ProjectListViewModelOutput

final class DefaultProjectListViewModel: ProjectListViewModel {
    
    // MARK: - Private Property
    private let projectUseCase: ProjectUseCase
    private let actions: ProjectListViewModelAction
    private let state: State
    private var cancellables: [AnyCancellable] = []
    
    @Published private var projects: [Project] = []
    @Published private var projectCount: Int = 0
    
    // MARK: - Life Cycle
    init(projectUseCase: ProjectUseCase,
         actions: ProjectListViewModelAction,
         state: State
    ) {
        self.projectUseCase = projectUseCase
        self.actions = actions
        self.state = state
        
        setupBindings()
    }
    
    private func setupBindings() {
        projectUseCase.readProjects().sink { [weak self] readProjects in
            guard let self else {
                return
            }
            
            let targetProjects = readProjects.filter {
                $0.state == self.state
            }
            
            projects = targetProjects
            projectCount = targetProjects.count
        }.store(in: &cancellables)
    }
    
    // MARK: - OUTPUT
    var projectsPublisher: Published<[Project]>.Publisher { $projects }
    var projectCountPublisher: Published<Int>.Publisher { $projectCount }
    var navigationTitle: String { state.rawValue }
}

// MARK: - INPUT View event methods
extension DefaultProjectListViewModel {
    func viewDidLoad() { }
    
    func handleLongPressGesture(target: UITableView, location: CGPoint) {
        guard let indexPath = target.indexPathForRow(at: location) else {
            return
        }
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.modalPresentationStyle = .popover
        alert.popoverPresentationController?.permittedArrowDirections = [.up, .down]
        alert.popoverPresentationController?.sourceView = target
        alert.popoverPresentationController?.sourceRect = CGRect(
            x: location.x,
            y: location.y,
            width: 0,
            height: 0
        )
        
        let allProjectStates = State.allCases
        allProjectStates
            .filter { $0 != self.state }
            .forEach { state in
                let action = UIAlertAction(title: "Move To \(state.rawValue)", style: .default) { [weak self] _ in
                    guard let self else {
                        return
                    }
                    
                    var targetProject = projects[indexPath.row]
                    targetProject.state = state
                    
                    projectUseCase.storeProject(targetProject)
                }
                
                alert.addAction(action)
        }
        
        actions.showPopAlert(alert)
    }
    
    func deleteItem(at index: Int) {
        projectUseCase.deleteProject(projects[index])
    }
    
    func selectItem(at index: Int) {
        actions.showEditProject(projects[index])
    }
}
