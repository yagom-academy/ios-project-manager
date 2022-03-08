//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {

    private let viewModel: MainViewModel
    private let bag = DisposeBag()
    private let tableView = UITableView()

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()

        self.viewModel.fetch()
    }

    private func configure() {
        self.view.backgroundColor = .white
        self.title = "ProjectManager"

        self.configureSubView()
        self.configureConstraint()
    }

    private func configureSubView() {
        self.view.addSubview(self.tableView)
        self.configureTableView()
        self.binding()
    }

    private func configureConstraint() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.tableView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3),
            self.tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor)
        ])
    }

    private func configureTableView() {
        self.tableView.register(cellWithClass: ScheduleListCell.self)
    }

    private func binding() {
        self.tableViewBinding()
    }

    private func tableViewBinding() {
        self.viewModel.schedules
            .drive(
                self.tableView.rx.items(
                    cellIdentifier: "ScheduleListCell",
                    cellType: ScheduleListCell.self
                )
            ) { _, item, cell in
                cell.titleLabel.text = item.title
                cell.bodyLabel.text = item.body
                cell.dateLabel.text = item.formattedDateString
            }
            .disposed(by: bag)
    }

}
