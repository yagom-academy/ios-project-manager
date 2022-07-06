//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import SnapKit
import RxSwift
import RxCocoa

final class MainViewController: UIViewController {
    private let todoHeaderView = HeaderVIew(ListType.todo)
    private let doingHeaderView = HeaderVIew(ListType.doing)
    private let doneHeaderView = HeaderVIew(ListType.done)
    
    private let mainViewModel = MainViewModel()
    private var disposbag = DisposeBag()
    
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentDetailView))
    }
    
    @objc private func presentDetailView() {
        let detailVC = DetailViewController()
        self.present(detailVC, animated: true, completion: nil)
    }
    
    private func setTableView() {
        bindTableView(todoTableView,
                      lists: mainViewModel.todoObservable,
                      headerView: todoHeaderView)
        bindTableView(doingTableView,
                      lists: mainViewModel.doingObservable,
                      headerView: doingHeaderView)
        bindTableView(doneTableView,
                      lists: mainViewModel.doneObservable,
                      headerView: doneHeaderView)
    }
    
    private func bindTableView(_ tableView: UITableView, lists: BehaviorSubject<[List]>, headerView: HeaderVIew) {
        lists.bind(to: tableView.rx.items(cellIdentifier: "\(ListTableViewCell.self)", cellType: ListTableViewCell.self)) { index, item, cell in
            cell.titleLabel.text = item.title
            cell.bodyLabel.text = item.body
            cell.deadlineLabel.text = item.deadline.description
        }
        .disposed(by: disposbag)
        
        lists
          .map { "\($0.count)"}
          .bind(to: headerView.countLabel.rx.text)
          .disposed(by: disposbag)
        
        tableView.rx.modelSelected(List.self)
            .bind(onNext: { [weak self] in
                print($0.title) //임시코드
                self?.presentDetailView()
            })
            .disposed(by: disposbag)
        
        tableView.rx.itemSelected
            .bind(onNext: { index in
                tableView.deselectRow(at: index, animated: true)
            })
            .disposed(by: disposbag)
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
