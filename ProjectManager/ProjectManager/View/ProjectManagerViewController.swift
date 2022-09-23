//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import RxSwift

final class ProjectManagerViewController: UIViewController {
    // MARK: - Properties
    private let viewModel = WorkViewModel(dbType: CoreDataManager.shared)
    private let disposeBag = DisposeBag()
    
    // MARK: - UI
    private let todoTableView = WorkTableView(frame: .zero, style: .plain)
    private let doingTableView = WorkTableView(frame: .zero, style: .plain)
    private let doneTableView = WorkTableView(frame: .zero, style: .plain)
    private let toDoTitleView = HeaderView()
    private let doingTitleView = HeaderView()
    private let doneTitleView = HeaderView()
    
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBinding()
    }
    
    // MARK: - UI setup
    private func setupView() {
        self.navigationItem.title = "Project Manager"
        self.view.backgroundColor = .systemGray6
        
        addSubView()
        setupConstraints()
        configureBarButton()
    }
    
    private func addSubView() {
        toDoTitleView.configure(title: "TODO", count: 0)
        doingTitleView.configure(title: "DOING", count: 0)
        doneTitleView.configure(title: "DONE", count: 0)
             
        horizontalStackView.addArrangedSubview(todoTableView)
        horizontalStackView.addArrangedSubview(doingTableView)
        horizontalStackView.addArrangedSubview(doneTableView)
        
        self.view.addSubview(horizontalStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            horizontalStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Bar Button
    private func configureBarButton() {
        let addWorkBarButton = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                               style: .plain, target: self,
                                               action: #selector(addWorkBarButtonTapped))
        let historyBarButton = UIBarButtonItem(title: "History",
                                               style: .plain, target: self,
                                               action: #selector(historyBarButtonTapped))
        
        self.navigationItem.rightBarButtonItem = addWorkBarButton
        self.navigationItem.leftBarButtonItem = historyBarButton
    }
    
    @objc private func addWorkBarButtonTapped() {
        let manageViewController = ManageWorkViewController(viewModel: viewModel)
        manageViewController.configureAddMode()
        let manageNavigationController = UINavigationController(rootViewController: manageViewController)
        self.present(manageNavigationController, animated: true)
    }
    
    @objc private func historyBarButtonTapped(_ button: UIBarButtonItem) {
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        controller.modalPresentationStyle = .popover
        controller.addAction(UIAlertAction(title: "Move", style: .default))
       
        guard let popover = controller.popoverPresentationController else { return }
        popover.barButtonItem = button
        present(controller, animated: true)
    }
    
    // MARK: - UI Binding
    private func setupBinding() {
        setupDelegate()
        bindWorkTableView()
        bindHeaderImage()
        setWorkSelection()
        setWorkDeletion()
    }
    
    private func bindWorkTableView() {
        let workTables = [todoTableView, doingTableView, doneTableView]
        let longGesture: (WorkState) -> UILongPressGestureRecognizer = { state in
            switch state {
            case .todo:
                return UILongPressGestureRecognizer(target: self, action: #selector(self.showTodoPopView))
            case .doing:
                return UILongPressGestureRecognizer(target: self, action: #selector(self.showDoingPopView))
            case .done:
                return UILongPressGestureRecognizer(target: self, action: #selector(self.showDonePopView))
            }
        }
        
        zip(workTables, WorkState.allCases).forEach { workTable, state in
            viewModel.worksObservable
                .map {
                    $0.filter { $0.state == state }
                }.observe(on: MainScheduler.instance)
                .bind(to: workTable.rx.items(cellIdentifier: WorkTableViewCell.identifier,
                                                 cellType: WorkTableViewCell.self)) { _, item, cell in
                    cell.configure(with: item)
                    cell.addGestureRecognizer(longGesture(state))
                }.disposed(by: disposeBag)
        }
    }
    
    private func bindHeaderImage() {
        let headerViews = [toDoTitleView, doingTitleView, doneTitleView]
        
        zip(headerViews, WorkState.allCases).forEach { header, state in
            viewModel.worksObservable
                .map {
                    $0.filter { $0.state == state }
                }.map {
                    UIImage(systemName: "\($0.count).circle.fill")
                }.bind(to: header.countImageView.rx.image)
                .disposed(by: disposeBag)
        }
    }
    
    private func setWorkSelection() {
        [todoTableView, doingTableView, doneTableView].forEach { workTable in
            workTable.rx.itemSelected
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { [weak self] index in
                    guard let self = self else { return }
                    guard let selectedCell = workTable.cellForRow(at: index) as? WorkTableViewCell else { return }
                    
                    self.showManageWorkView(self, id: selectedCell.cellID)
                    workTable.deselectRow(at: index, animated: true)
                }).disposed(by: disposeBag)
        }
    }
    
    private func setWorkDeletion() {
        [todoTableView, doingTableView, doneTableView].forEach { workTable in
            workTable.rx.itemDeleted
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { [weak self] index in
                    guard let self = self else { return }
                    guard let deletedCell = workTable.cellForRow(at: index) as? WorkTableViewCell else { return }
                    self.viewModel.deleteWork(id: deletedCell.cellID)
                }).disposed(by: disposeBag)
        }
    }
    
    // MARK: - Methods
    private func showManageWorkView(_ view: UIViewController, id: UUID) {
        let manageViewController = ManageWorkViewController(viewModel: viewModel)
        guard let work = viewModel.selectWork(id: id) else { return }
        manageViewController.configureEditMode(with: work)

        let manageNavigationController = UINavigationController(rootViewController: manageViewController)
        view.present(manageNavigationController, animated: true)
    }
}

// MARK: - popover
extension ProjectManagerViewController {
    @objc private func showTodoPopView(_ recognizer: UILongPressGestureRecognizer) {
        let point = recognizer.location(in: todoTableView)
        guard let index = todoTableView.indexPathForRow(at: point),
              let seletedCell = todoTableView.cellForRow(at: index) as? WorkTableViewCell else { return }
        showPopView(seletedCell.cellID, recognizer.view)
    }
    
    @objc private func showDoingPopView(_ recognizer: UILongPressGestureRecognizer) {
        let point = recognizer.location(in: doingTableView)
        guard let index = doingTableView.indexPathForRow(at: point),
              let seletedCell = doingTableView.cellForRow(at: index) as? WorkTableViewCell else { return }
        
        showPopView(seletedCell.cellID, recognizer.view)
    }
    
    @objc private func showDonePopView(_ recognizer: UILongPressGestureRecognizer) {
        let point = recognizer.location(in: doneTableView)
        guard let index = doneTableView.indexPathForRow(at: point),
              let seletedCell = doneTableView.cellForRow(at: index) as? WorkTableViewCell else { return }
        
        showPopView(seletedCell.cellID, recognizer.view)
    }
    
    private func showPopView(_ id: UUID, _ sourceView: UIView?) {
        guard let work = viewModel.selectWork(id: id) else { return }
        let changeWorkStateViewController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        changeWorkStateViewController.modalPresentationStyle = .popover
        
        WorkState.allCases.filter {
            $0 != work.state
        }.forEach { state in
            let action = UIAlertAction(title: "Move to " + state.rawValue, style: .default) { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.changeWorkState(work, to: state)
                self.dismiss(animated: true)
            }
            changeWorkStateViewController.addAction(action)
        }

        guard let popController = changeWorkStateViewController.popoverPresentationController else { return }
        popController.permittedArrowDirections = .up
        popController.sourceView = sourceView
        self.navigationController?.present(changeWorkStateViewController, animated: true)
    }
}

// MARK: - Delegate
extension ProjectManagerViewController: UITableViewDelegate {
    private func setupDelegate() {
        todoTableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        doingTableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        doneTableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch tableView {
        case todoTableView:
            return toDoTitleView
        case doingTableView:
            return doingTitleView
        case doneTableView:
            return doneTitleView
        default:
            return toDoTitleView
        }
    }
}
