//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import SnapKit
import RxSwift
import RxCocoa

final class MainViewController: UIViewController {
    private let todoHeaderView = HeaderView(ListType.todo)
    private let doingHeaderView = HeaderView(ListType.doing)
    private let doneHeaderView = HeaderView(ListType.done)
    
    private lazy var todoTableView = listTableView()
    private lazy var  doingTableView = listTableView()
    private lazy var  doneTableView = listTableView()
    
    private let viewModel: MainViewModelInOut
    private var disposebag = DisposeBag()
    
    init(viewModel: MainViewModelInOut) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitailView()
    }
    
    private func setInitailView() {
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
        self.present(Container.shared.makeAddViewController(), animated: true)
    }
    
    private func didtapCell(_ listItem: ListItem) {
        let detailVC = EditlViewController(viewModel: viewModel, listItem: listItem)
        self.present(detailVC, animated: true)
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
