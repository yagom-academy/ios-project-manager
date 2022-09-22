//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import RxSwift

final class ProjectManagerViewController: UIViewController {
    // MARK: - Properties
    private let viewModel = WorkViewModel()
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
        configureAddBarButton()
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
    
    private func configureAddBarButton() {
        let addWorkBarButton = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                               style: .plain, target: self,
                                               action: #selector(addWorkBarButtonTapped))
        self.navigationItem.rightBarButtonItem = addWorkBarButton
    }
    
    @objc private func addWorkBarButtonTapped() {
        let manageViewController = ManageWorkViewController(viewModel: viewModel)
        manageViewController.configureAddMode()
        let manageNavigationController = UINavigationController(rootViewController: manageViewController)
        self.present(manageNavigationController, animated: true)
    }
    
    // MARK: - UI Binding
    private func setupBinding() {
        setupDelegate()
        bindWorkTableView()
        bindHeaderImage()
        setWorkSelection()
        setWorkDeletion()
    }
    
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
    
    private func bindWorkTableView() {
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
        
        viewModel.worksObservable
            .map {
                $0.filter { $0.state == .todo }
            }.observe(on: MainScheduler.instance)
            .bind(to: todoTableView.rx.items(cellIdentifier: WorkTableViewCell.identifier,
                                             cellType: WorkTableViewCell.self)) { _, item, cell in
                cell.configure(with: item)
                cell.addGestureRecognizer(longGesture(item.state))
            }.disposed(by: disposeBag)
        
        viewModel.worksObservable
            .map {
                $0.filter { $0.state == .doing }
            }.observe(on: MainScheduler.instance)
            .bind(to: doingTableView.rx.items(cellIdentifier: WorkTableViewCell.identifier,
                                                                cellType: WorkTableViewCell.self)) { _, item, cell in
                cell.configure(with: item)
                cell.addGestureRecognizer(longGesture(item.state))
           }.disposed(by: disposeBag)
        
        viewModel.worksObservable
            .map {
                $0.filter { $0.state == .done }
            }.observe(on: MainScheduler.instance)
            .bind(to: doneTableView.rx.items(cellIdentifier: WorkTableViewCell.identifier,
                                             cellType: WorkTableViewCell.self)) { _, item, cell in
                cell.configure(with: item)
                cell.addGestureRecognizer(longGesture(item.state))
            }.disposed(by: disposeBag)
    }
    
    private func bindHeaderImage() {
        viewModel.worksObservable
            .map {
                $0.filter { $0.state == .todo }
            }.map {
                UIImage(systemName: "\($0.count).circle.fill")
            }.asDriver(onErrorJustReturn: nil)
            .drive(toDoTitleView.countImageView.rx.image)
            .disposed(by: disposeBag)
        
        viewModel.worksObservable
            .map {
                $0.filter { $0.state == .doing }
            }.map {
                UIImage(systemName: "\($0.count).circle.fill")
            }
            .asDriver(onErrorJustReturn: nil)
            .drive(doingTitleView.countImageView.rx.image)
            .disposed(by: disposeBag)
        
        viewModel.worksObservable
            .map {
                $0.filter { $0.state == .done }
            }.map {
                UIImage(systemName: "\($0.count).circle.fill")
            }
            .asDriver(onErrorJustReturn: nil)
            .drive(doneTitleView.countImageView.rx.image)
            .disposed(by: disposeBag)
    }
    
    private func setWorkSelection() {
        todoTableView.rx.itemSelected
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] index in
                guard let self = self else { return }
                guard let selectedCell = self.todoTableView.cellForRow(at: index) as? WorkTableViewCell else { return }
                
                self.showManageWorkView(self, id: selectedCell.cellID)
                self.todoTableView.deselectRow(at: index, animated: true)
            }).disposed(by: disposeBag)
        
        doingTableView.rx.itemSelected
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] index in
                guard let self = self else { return }
                guard let selectedCell = self.doingTableView.cellForRow(at: index) as? WorkTableViewCell else { return }
                
                self.showManageWorkView(self, id: selectedCell.cellID)
                self.doingTableView.deselectRow(at: index, animated: true)
            }).disposed(by: disposeBag)
        
        doneTableView.rx.itemSelected
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] index in
                guard let self = self else { return }
                guard let selectedCell = self.doneTableView.cellForRow(at: index) as? WorkTableViewCell else { return }
                
                self.showManageWorkView(self, id: selectedCell.cellID)
                self.doneTableView.deselectRow(at: index, animated: true)
            }).disposed(by: disposeBag)
    }
    
    private func setWorkDeletion() {
        todoTableView.rx.itemDeleted
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] index in
                guard let self = self else { return }
                guard let deletedCell = self.todoTableView.cellForRow(at: index) as? WorkTableViewCell else { return }
                self.viewModel.deleteWork(id: deletedCell.cellID)
            }).disposed(by: disposeBag)
        
        doingTableView.rx.itemDeleted
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] index in
                guard let self = self else { return }
                guard let deletedCell = self.doingTableView.cellForRow(at: index) as? WorkTableViewCell else { return }
                self.viewModel.deleteWork(id: deletedCell.cellID)
            }).disposed(by: disposeBag)
        
        doneTableView.rx.itemDeleted
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] index in
                guard let self = self else { return }
                guard let deletedCell = self.doneTableView.cellForRow(at: index) as? WorkTableViewCell else { return }
                self.viewModel.deleteWork(id: deletedCell.cellID)
            }).disposed(by: disposeBag)
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

extension ProjectManagerViewController: UITableViewDelegate {
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
