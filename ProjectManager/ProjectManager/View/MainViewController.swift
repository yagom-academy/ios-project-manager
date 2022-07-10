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
    
    private let mainViewModel = MainViewModel()
    private var disposebag = DisposeBag()
    
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
        let detailVC = DetailViewController(list: nil)
        self.present(detailVC, animated: true)
    }
    
    private func didtapCell(_ list: List) {
        let detailVC = DetailViewController(list: list)
        self.present(detailVC, animated: true)
    }
    
    private func setTableView() {
        bindTableView(todoTableView,
                      lists: mainViewModel.separatLists(.todo),
                      headerView: todoHeaderView)
        bindTableView(doingTableView,
                      lists: mainViewModel.separatLists(.doing),
                      headerView: doingHeaderView)
        bindTableView(doneTableView,
                      lists: mainViewModel.separatLists(.done),
                      headerView: doneHeaderView)
    }
    
    private func bindTableView(_ tableView: UITableView, lists: Observable<[List]>, headerView: HeaderView) {
        lists.bind(to: tableView.rx.items(cellIdentifier: "\(ListTableViewCell.self)", cellType: ListTableViewCell.self)) { [weak self] index, item, cell in
            guard let self = self else {
                return
            }
            
            cell.setViewContents(item, isOver: self.mainViewModel.isOverDeadline(list: item))
        }
        .disposed(by: disposebag)
        
        lists
          .map { "\($0.count)"}
          .bind(to: headerView.countLabel.rx.text)
          .disposed(by: disposebag)
        
        tableView.rx.modelSelected(List.self)
            .bind(onNext: { [weak self] in
                self?.didtapCell($0)
            })
            .disposed(by: disposebag)
        
        tableView.rx.itemSelected
            .bind(onNext: { index in
                tableView.deselectRow(at: index, animated: true)
            })
            .disposed(by: disposebag)
    }
    
    // MARK: - UI Components
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews:
                                        [todoStackView,
                                         doingStackView,
                                         doneStackView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.backgroundColor = .systemGray4
        return stackView
    }()
    
    private lazy var todoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [todoHeaderView,
                                                       todoTableView])
        stackView.axis = .vertical
        stackView.spacing = 1
        
        return stackView
    }()
    
    private lazy var todoTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        tableView.register(ListTableViewCell.self,
                           forCellReuseIdentifier: "\(ListTableViewCell.self)")
        
        return tableView
    }()
    
    private lazy var doingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [doingHeaderView,
                                                       doingTableView])
        stackView.axis = .vertical
        stackView.spacing = 1
        
        return stackView
    }()
    
    private lazy var doingTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        tableView.register(ListTableViewCell.self,
                           forCellReuseIdentifier: "\(ListTableViewCell.self)")
        return tableView
    }()
    
    private lazy var doneStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [doneHeaderView,
                                                       doneTableView])
        stackView.axis = .vertical
        stackView.spacing = 1
        
        return stackView
    }()
    
    private lazy var doneTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        tableView.register(ListTableViewCell.self,
                           forCellReuseIdentifier: "\(ListTableViewCell.self)")
        return tableView
    }()
}
