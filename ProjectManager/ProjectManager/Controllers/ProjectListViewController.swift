//
//  ProjectListViewController.swift
//  ProjectManager
//
//  Created by junho lee on 2023/01/13.
//

import UIKit

class ProjectListViewController: UIViewController {
    // MARK: - Properties
    private let projectStateCount: Int
    private var projects: [Project] = []
    private var collectionViews: [UICollectionView] = []
    private var dataSources: [DataSource] = []
    private var projectHeaderViews: [ProjectHeaderView] = []
    private var projectStackViews: [UIStackView] = []
    private let stackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = Constants.defaultSpacing
        return stackView
    }()

    // MARK: - Configure
    init?(projectStateCount: Int) {
        guard projectStateCount > 0 else { return nil }
        self.projectStateCount = projectStateCount
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = ProjectColor.listViewBackground.color
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        configureSubViewsArray()
        configureCollectionViews()
        configureDataSources()
        configureHierarchy()
        configureSampleData()
        updateSnapshot()
        updateProjectHeaderViewText()
    }

    private func configureNavigationItem() {
        navigationItem.title = Constants.programName
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(didPressAddButton))
    }

    private func configureSubViewsArray() {
        (0..<projectStateCount).forEach { _ in
            projectHeaderViews.append(ProjectHeaderView())
            projectStackViews.append({
                let stackView = UIStackView()
                stackView.translatesAutoresizingMaskIntoConstraints = false
                stackView.axis = .vertical
                stackView.spacing = Constants.defaultSpacing
                return stackView
            }())
        }
    }

    private func configureCollectionViews() {
        (0..<projectStateCount).forEach { _ in
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewLayout())
            collectionView.delegate = self
            collectionViews.append(collectionView)
        }
    }

    private func makeCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.showsSeparators = false
        configuration.backgroundColor = ProjectColor.collectionViewBackground.color
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }

    private func configureDataSources() {
        collectionViews.forEach { collectionView in
            let cellRegistration = UICollectionView.CellRegistration(handler: makeCellRegistrationHandler)
            let dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            }
            dataSources.append(dataSource)
        }
    }

    private func configureHierarchy() {
        (0..<projectStateCount).forEach { index in
            projectStackViews[index].addArrangedSubview(projectHeaderViews[index])
            projectStackViews[index].addArrangedSubview(collectionViews[index])
            stackView.addArrangedSubview(projectStackViews[index])
        }
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - DataSource
extension ProjectListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, UUID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, UUID>

    private func makeCellRegistrationHandler(cell: UICollectionViewCell, indexPath: IndexPath, id: UUID) {
        guard let project = project(for: id) else { return }
        var configuration = ProjectListContentView.Configuration()
        configuration.title = project.title
        configuration.description = project.description
        configuration.dueDateAttributedText = createDueDateAttributedString(project.dueDate)
        cell.contentConfiguration = configuration
    }

    private func updateSnapshot(_ reloadItemIDs: [UUID] = []) {
        dataSources.enumerated().forEach { index, dataSource in
            updateSnapshot(for: dataSource, stateIndex: index, reloadItemIDs: reloadItemIDs)
        }
    }

    private func updateSnapshot(for dataSource: DataSource, stateIndex: Int, reloadItemIDs: [UUID] = []) {
        var snapShot = Snapshot()
        snapShot.appendSections([0])
        let items = projectIDs(for: stateIndex)
        snapShot.appendItems(items)
        if reloadItemIDs.isEmpty == false {
            let reloadItems = Array(Set(reloadItemIDs).intersection(items))
            snapShot.reloadItems(reloadItems)
        }
        dataSource.apply(snapShot)
    }

    private func updateProjectHeaderViewText() {
        projectHeaderViews.enumerated().forEach { index, projectHeaderView in
            guard let projectState = projectState(for: index) else { return }
            projectHeaderView.titleLabel.text = String(describing: projectState)
            let projectsCount = projectsCount(for: index)
            let maxCount = Constants.itemCountLabelMaxCount
            projectHeaderView.itemCountLabel.text = projectsCount > maxCount ? "\(maxCount)+" : "\(projectsCount)"
        }
    }
}

// MARK: - Project Data
extension ProjectListViewController {
    private func configureSampleData() {
        projects = Project.sampleProjects
    }

    private func project(for projectID: UUID) -> Project? {
        guard let project = projects.first(where: { $0.id == projectID }) else { return nil }
        return project
    }

    private func projectIDs(for stateIndex: Int) -> [UUID] {
        return projects.filter { $0.state.rawValue == stateIndex }.map { $0.id }
    }

    private func projectState(for index: Int) -> ProjectState? {
            guard let projectState = ProjectState(rawValue: index) else { return nil }
            return projectState
    }

    private func projectsCount(for index: Int) -> Int {
        return projects.filter { $0.state.rawValue == index }.count
    }

    private func createDueDateAttributedString(_ dueDate: Date) -> NSAttributedString {
        if dueDate.isEarlierThanToday() {
            return NSAttributedString(string: dueDate.localizedDateString(),
                                      attributes: [.foregroundColor: ProjectColor.overdueDate.color])
        } else {
            return NSAttributedString(string: dueDate.localizedDateString())
        }
    }

    private func add(project: Project) {
        projects.append(project)
    }

    private func update(project: Project) {
        guard let index = projects.firstIndex(where: { $0.id == project.id }) else { return }
        projects[index] = project
    }
}

// MARK: - Actions
extension ProjectListViewController {
    @objc
    private func didPressAddButton(_ sender: UIBarButtonItem) {
        let newProject = Project(title: "", description: "", dueDate: Date())
        let projectDetailViewController = ProjectDetailViewController(navigationTitle: String(describing: newProject.state),
                                                                      project: newProject,
                                                                      isAdding: true) { [weak self] project in
            guard let project else { return }
            self?.add(project: project)
            self?.updateSnapshot()
            self?.updateProjectHeaderViewText()
            self?.dismiss(animated: true)
        }
        let navigationController = UINavigationController(rootViewController: projectDetailViewController)
        present(navigationController, animated: true)
    }
}

// MARK: - CollectionViewDelegate
extension ProjectListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dataSource = collectionView.dataSource as? DataSource,
              let itemIdentifier = dataSource.itemIdentifier(for: indexPath),
              let project = project(for: itemIdentifier) else { return }
        let projectDetailViewController = ProjectDetailViewController(navigationTitle: String(describing: project.state),
                                                                      project: project,
                                                                      isAdding: false) { [weak self] project in
            guard let project else { return }
            self?.update(project: project)
            self?.updateSnapshot([project.id])
            self?.updateProjectHeaderViewText()
            self?.dismiss(animated: true)
        }
        let navigationController = UINavigationController(rootViewController: projectDetailViewController)
        present(navigationController, animated: true)
    }
}
