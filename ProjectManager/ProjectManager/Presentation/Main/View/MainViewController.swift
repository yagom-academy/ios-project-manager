//
//  MainViewController.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/04.
//

import RxSwift
import RxCocoa
import RxGesture

private enum ImageConstant {
    static let connectedNetwork = "wifi"
    static let unconnectedNetwork = "wifi.slash"
    static let fetchingNetworkData = "icloud.and.arrow.down"
}

final class MainViewController: UIViewController {
    private let mainView = MainView(frame: .zero)
    private var viewModel: MainViewModel?
    private let disposeBag = DisposeBag()
    private var sceneDIContainer: SceneDIContainer?
    
    static func create(
        with viewModel: MainViewModel,
        _ sceneDIContainer: SceneDIContainer
    ) -> MainViewController {
        let viewController = MainViewController()
        viewController.viewModel = viewModel
        viewController.sceneDIContainer = sceneDIContainer
        return viewController
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    private func bind() {
        setUpNavigationItem()
        setUpTable()
        setUpTotalCount()
        setUpGesture()
    }
    
    private func setUpNavigationItem() {
        navigationItem.title = "Project Manager"
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: nil,
            action: nil
        )
        
        let networkConditionImage = UIImage(
            systemName: ImageConstant.connectedNetwork
        )?.withTintColor(
            .systemBlue,
            renderingMode: .alwaysOriginal
        )
        
        let networkConditionItem = UIBarButtonItem(
            image: networkConditionImage,
            style: .plain,
            target: nil,
            action: nil
        )
        networkConditionItem.isEnabled = false
        
        let loadButton = UIBarButtonItem(
            image: UIImage(systemName: ImageConstant.fetchingNetworkData),
            style: .done,
            target: nil,
            action: nil
        )
        
        navigationItem.rightBarButtonItems = [addButton, loadButton, networkConditionItem]
        didTapAddButton()
        didTapLoadButton()
        
        NetworkCondition.sharedInstance.delegate = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "History",
            style: .plain,
            target: nil,
            action: nil
        )
        didTapHistoryButton()
    }
    
    private func didTapHistoryButton() {
        guard let historyButton = navigationItem.leftBarButtonItem else {
            return
        }
        
        historyButton.rx.tap
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.presentHistoryPopOver(source: historyButton)
            })
            .disposed(by: disposeBag)
    }
    
    private func presentHistoryPopOver(source: UIBarButtonItem) {
        guard let historyViewController = sceneDIContainer?.makeHistoryViewController(with: source) else {
            return
        }
        
        present(historyViewController, animated: true)
    }
    
    private func didTapAddButton() {
        guard let addButton = navigationItem.rightBarButtonItem else {
            return
        }
        
        addButton.rx.tap
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.presentRegistrationView()
            })
            .disposed(by: disposeBag)
    }
    
    private func didTapLoadButton() {
        guard let loadButton = navigationItem.rightBarButtonItems?[1] else {
            return
        }
        
        loadButton.rx.tap
            .asObservable()
            .withUnretained(self)
            .subscribe(onNext: { (self, _) in
                guard let alertController = self.presentAlert() else {
                    return
                }
                
                self.present(alertController, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
    private func presentAlert() -> UIAlertController? {
        let alertAction = UIAlertAction(title: "확인", style: .destructive) { [weak self]_ in
            guard let self = self else {
                return
            }
            
            self.viewModel?.loadNetworkData()
                .disposed(by: self.disposeBag)
        }
        
        let next = sceneDIContainer?.makeAlertController(
            over: self,
            title: "서버 데이터를 사용자 기기로 동기화할까요?",
            confirmButton: alertAction
        )
        
        return next
    }
    
    private func presentRegistrationView() {
        guard let next = sceneDIContainer?.makeRegistrationViewController() else {
            return
        }
        
        next.modalPresentationStyle = .overCurrentContext
        next.modalTransitionStyle = .crossDissolve
        
        present(next, animated: true)
    }
    
    private func setUpTable() {
        setUpSelection()
        setUpTableCellData()
        deleteProject()
    }
    
    private func setUpSelection() {
        bindItemSelected(to: mainView.toDoTable.tableView)
        bindItemSelected(to: mainView.doingTable.tableView)
        bindItemSelected(to: mainView.doneTable.tableView)
    }
    
    private func bindItemSelected(to tableView: UITableView) {
        tableView.rx
            .itemSelected
            .bind { indexPath in
                tableView.deselectRow(at: indexPath, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func setUpTableCellData() {
        bindCell(to: viewModel?.asTodoProjects(), at: mainView.toDoTable.tableView)
        bindCell(to: viewModel?.asDoingProjects(), at: mainView.doingTable.tableView)
        bindCell(to: viewModel?.asDoneProjects(), at: mainView.doneTable.tableView)
    }
    
    private func bindCell(to projects: Driver<[ProjectEntity]>?, at tableView: UITableView) {
        projects?
            .drive(tableView.rx.items(
                cellIdentifier: "\(ProjectCell.self)",
                cellType: ProjectCell.self)
            ) { _, item, cell in
                cell.compose(content: item)
            }
            .disposed(by: disposeBag)
    }
    
    private func deleteProject() {
        bindModelDeleted(at: mainView.toDoTable.tableView)
        bindModelDeleted(at: mainView.doingTable.tableView)
        bindModelDeleted(at: mainView.doneTable.tableView)
    }
    
    private func bindModelDeleted(at tableView: UITableView) {
        tableView.rx
            .modelDeleted(ProjectEntity.self)
            .asDriver()
            .drive { [weak self] project in
                self?.viewModel?.deleteProject(project)
            }
            .disposed(by: disposeBag)
    }
    
    private func setUpTotalCount() {
        bindCountLabel(of: mainView.toDoTable, to: viewModel?.asTodoProjects())
        bindCountLabel(of: mainView.doingTable, to: viewModel?.asDoingProjects())
        bindCountLabel(of: mainView.doneTable, to: viewModel?.asDoneProjects())
    }
    
    private func bindCountLabel(of tableView: ProjectListView, to projects: Driver<[ProjectEntity]>?) {
        projects?
            .map { "\($0.count)" }
            .drive { count in
                tableView.compose(projectCount: count)
            }
            .disposed(by: disposeBag)
    }
    
    private func setUpGesture() {
        bindGesture(to: mainView.toDoTable.tableView, status: .todo)
        bindGesture(to: mainView.doingTable.tableView, status: .doing)
        bindGesture(to: mainView.doneTable.tableView, status: .done)
    }
    
    private func bindGesture(to tableView: UITableView, status: ProjectStatus) {
        let gesture = tableView.rx
            .anyGesture(
                (.tap(), when: .recognized),
                (.longPress(), when: .began)
            )
            .asObservable()
        
        gesture.filter { $0.state == .recognized }
            .bind { [weak self] in
                guard let cell = self?.findCell(by: $0, in: tableView) else {
                    return
                }
                self?.presentViewController(status: status, cell: cell)
            }
            .disposed(by: disposeBag)
        
        gesture.filter { $0.state == .began }
            .compactMap { [weak self] in
                self?.findCell(by: $0, in: tableView)
            }
            .bind { [weak self] in
                self?.presentPopOver($0)
            }
            .disposed(by: disposeBag)
    }
    
    private func findCell(by event: RxGestureRecognizer, in tableView: UITableView) -> ProjectCell? {
        let point = event.location(in: tableView)
        
        guard let indexPath = tableView.indexPathForRow(at: point),
              let cell = tableView.cellForRow(at: indexPath) as? ProjectCell else {
            return nil
        }
        
        return cell
    }
    
    private func presentPopOver(_ cell: ProjectCell) {
        guard let popOverViewController = sceneDIContainer?.makePopOverViewController(with: cell) else {
            return
        }
        
        present(popOverViewController, animated: true)
    }
    
    private func presentViewController(status: ProjectStatus, cell: ProjectCell) {
        guard let content = viewModel?.readProject(cell.contentID),
              let next = sceneDIContainer?.makeDetailViewController(with: content)
        else {
            return
        }
        
        next.modalPresentationStyle = .overCurrentContext
        next.modalTransitionStyle = .crossDissolve
        
        self.present(next, animated: true)
    }
}

extension MainViewController: NetworkConditionDelegate {
    func applyNetworkEnable() {
        navigationItem.rightBarButtonItems?[2].image = UIImage(
            systemName: ImageConstant.connectedNetwork
        )?.withTintColor(
            .systemBlue,
            renderingMode: .alwaysOriginal
        )
    }
    
    func applyNetworkUnable() {
        navigationItem.rightBarButtonItems?[2].image = UIImage(
            systemName: ImageConstant.unconnectedNetwork
        )?.withTintColor(
            .systemRed,
            renderingMode: .alwaysOriginal
        )
    }
}
