//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import SnapKit
import RxSwift
import RxCocoa
import RxGesture

final class MainViewController: UIViewController {
    private let todoHeaderView = HeaderView(ListType.todo)
    private let doingHeaderView = HeaderView(ListType.doing)
    private let doneHeaderView = HeaderView(ListType.done)
    
    private lazy var todoTableView = listTableView()
    private lazy var  doingTableView = listTableView()
    private lazy var  doneTableView = listTableView()
    
    private let viewModel: MainViewModelInOut
    private let container: Container
    private var disposebag = DisposeBag()
    
    init(viewModel: MainViewModelInOut, container: Container) {
        self.viewModel = viewModel
        self.container = container
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialView()
    }
    
    private func setInitialView() {
        self.view.backgroundColor = .systemGray5
        self.view.addSubview(mainStackView)
        mainStackView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        setTableView()
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        self.title = "Project Manger"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
    }
    
    @objc private func didTapAddButton() {
        self.present(container.makeAddViewController(), animated: true)
    }
    
    private func didtapCell(_ listItem: ListItem) {
        self.present(container.makeEditViewController(listItem), animated: true)
    }
    
    private func setTableView() {
        bindTableView(todoTableView,
                      list: viewModel.todoList,
                      headerView: todoHeaderView,
                      type: .todo)
        bindTableView(doingTableView,
                      list: viewModel.doingList,
                      headerView: doingHeaderView,
                      type: .doing)
        bindTableView(doneTableView,
                      list: viewModel.doneList,
                      headerView: doneHeaderView,
                      type: .done)
    }
    
    private func bindTableView(_ tableView: UITableView, list: Driver<[ListItem]>, headerView: HeaderView, type: ListType) {
        list
            .drive(tableView.rx.items(cellIdentifier: "\(ListTableViewCell.self)", cellType: ListTableViewCell.self)) { [weak self] index, item, cell in
                guard let self = self else {
                    return
                }
                
                cell.setViewContents(item, isOver: self.viewModel.isOverDeadline(listItem: item))
            }
            .disposed(by: disposebag)
        
        list
          .map { "\($0.count)"}
          .drive(headerView.countLabel.rx.text)
          .disposed(by: disposebag)
        
        tableView.rx.itemSelected
            .bind(onNext: { index in
                
                self.viewModel.peekList(index: index.row, type: type) {
                    self.didtapCell($0)
                }
                tableView.deselectRow(at: index, animated: true)
            })
            .disposed(by: disposebag)
        
        tableView.rx.itemDeleted
            .bind(onNext: {
                self.viewModel.deleteList(index: $0.row, type: type)
            })
            .disposed(by: disposebag)
        
        tableView.rx.longPressGesture()
            .when(.began)
            .bind(onNext: { [weak self] in
                let location = $0.location(in: tableView)
                
                self?.showAlert(location: location, tableView: tableView, type: type)
            })
            .disposed(by: disposebag)
    }
    
    private func makeAlert(index: Int, type: ListType) -> UIAlertController {
        let alert = UIAlertController(title: nil,
                                      message: nil,
                                      preferredStyle: .actionSheet)
        
        let firstAction = UIAlertAction(title: type.firstDirection.title,
                                        style: .default) { [weak self] _ in
            self?.viewModel.changeListType(index: index,
                                           type: type,
                                           to: type.firstDirection.type)
        }
        
        let secondAction = UIAlertAction(title: type.secondDirection.title,
                                         style: .default) { [weak self] _ in
            self?.viewModel.changeListType(index: index,
                                           type: type,
                                           to: type.secondDirection.type)
        }
        alert.addAction(firstAction)
        alert.addAction(secondAction)
        
        return alert
    }
    
    private func showAlert(location: CGPoint, tableView: UITableView, type: ListType) {
        guard let indexPath = tableView.indexPathForRow(at: location) else {
            return
        }
        
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }
        
        let alert = makeAlert(index: indexPath.row, type: type)

        guard let popoverPresentationController = alert.popoverPresentationController else {
            return
        }

        popoverPresentationController.sourceView = cell
        
        let checkLoation = location.y < UIScreen.main.bounds.height * 3 / 5
        let yPosition = cell.bounds.height / 2
        
        popoverPresentationController.sourceRect = CGRect(x: 0,
                                      y: checkLoation ? -yPosition : yPosition,
                                      width: cell.bounds.width,
                                      height: cell.bounds.height)
        popoverPresentationController.permittedArrowDirections = checkLoation ? .up : .down
        
        self.present(alert, animated: true)
    }
    
    // MARK: - UI Components
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews:[listStackView(headerView: todoHeaderView,
                                                                     tableView: todoTableView),
                                                      listStackView(headerView: doingHeaderView,
                                                                     tableView: doingTableView),
                                                      listStackView(headerView: doneHeaderView,
                                                                     tableView: doneTableView)])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.backgroundColor = .systemGray4
        return stackView
    }()
    
    private func listStackView(headerView: HeaderView, tableView: UITableView) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [headerView,
                                                       tableView])
        stackView.axis = .vertical
        stackView.spacing = 1
        
        return stackView
    }
    
    private func listTableView() -> UITableView {
        let tableView = UITableView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        tableView.backgroundColor = .systemGray6
        tableView.register(ListTableViewCell.self)
        
        return tableView
    }
}
