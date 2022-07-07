//
//  ListView.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/06.
//

import UIKit

import RxCocoa
import RxSwift


final class ListView: UIViewController {
    private let mode: Mode
    private let tableView: UITableView
    private var viewModel: TodoListViewModel
    private let disposeBag = DisposeBag()
    
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        
        return view
    }()
    
    private let headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.backgroundColor = .systemGray6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var headerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = self.mode.value
        label.font = .preferredFont(forTextStyle: .title1)
        
        return label
    }()
    
    private let listCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBackground
        label.backgroundColor = .label
        label.text = "5"
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 18
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let todoListStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    init(mode: Mode) {
        self.mode = mode
        self.tableView = UITableView()
        self.viewModel = TodoListViewModel()
        super.init(nibName: nil, bundle: nil)
        self.setUpListView()
        self.setUpHeaderView()
        self.bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpListView() {
        self.tableView.register(TodoListCell.self, forCellReuseIdentifier: TodoListCell.identifier)
        
        self.view.addSubview(self.todoListStackView)
        self.todoListStackView.addArrangedSubviews(with: [self.headerView, self.tableView])
        
        NSLayoutConstraint.activate([
            self.todoListStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.todoListStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.todoListStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.todoListStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setUpHeaderView() {
        self.headerView.addSubview(self.headerStackView)
        self.headerStackView.addArrangedSubviews(with: [self.headerTitleLabel, self.listCountLabel])
        
        NSLayoutConstraint.activate([
            self.headerStackView.topAnchor.constraint(equalTo: self.headerView.topAnchor, constant: 10),
            self.headerStackView.bottomAnchor.constraint(equalTo: self.headerView.bottomAnchor, constant: -10),
            self.headerStackView.leadingAnchor.constraint(equalTo: self.headerView.leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            self.listCountLabel.widthAnchor.constraint(equalTo: self.listCountLabel.heightAnchor)
        ])
    }
    
    private func bind() {
        self.viewModel.tableViewData?
            .bind(to: self.tableView.rx.items) { tabelView, row, element in
                guard let cell = tabelView.dequeueReusableCell(
                    withIdentifier: TodoListCell.identifier,
                    for: IndexPath(row: row, section: .zero)) as? TodoListCell
                else {
                    return UITableViewCell()
                }
                cell.configure(element)
                
                return cell
            }
            .disposed(by: disposeBag)
        
//        1. 필터 쓰면 코드 깔끔해질거같음 근데 ListView인스턴스 3개가 필터써야되서 성능저하? 의심됨
//        2. 뷰모델에서 저장된데이터를 분류 한후 ListView인스턴스의 mode타입에따라 어떤데이터를 가져올지 분기처리해주어야함.(로직이 좀 길어질듯함)
        
//        viewModel.tableViewData?
//            .filter { $0.
//
//            }
//            .bind(to: self.listCountLabel.rx.text)
//            .disposed(by: disposeBag)
    }
}
