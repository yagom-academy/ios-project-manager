//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import RxSwift
import RxCocoa

final class MainViewController: UIViewController {

// MARK: - Properties
    var viewModel: MainViewModel?

    private let bag = DisposeBag()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 2.0
        return stackView
    }()
    private let tableViews: [UITableView] = Progress.allCases.map { _ in UITableView() }
    private let addBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.title = "+"
        return barButton
    }()

// MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
}

// MARK: - Private Methods

private extension MainViewController {

    func configure() {
        self.view.backgroundColor = .white
        self.configureNavigationBar()
        self.configureSubView()
    }

    func configureSubView() {
        self.configureHierarchy()
        self.configureConstraint()
        self.configureTableView()
        self.binding()
    }

    func configureHierarchy() {
        self.view.addSubview(stackView)
        self.tableViews.forEach { tableView in
            self.stackView.addArrangedSubview(tableView)
        }
    }

    func configureNavigationBar() {
        self.title = "ProjectManager"
        self.navigationItem.rightBarButtonItem = addBarButton
    }

    func configureConstraint() {
        let safeAreaLayoutGuide = self.view.safeAreaLayoutGuide
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            self.stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func configureTableView() {
        self.tableViews.forEach { tableView in
            tableView.register(cellWithClass: ScheduleListCell.self)
            tableView.delegate = self
        }
    }

    func binding() {
        self.tableViewBinding()
    }

    func tableViewBinding() {
        let input = MainViewModel.Input(
            viewWillAppear: self.rx.methodInvoked(#selector(UIViewController.viewWillAppear))
                .map { _ in },
            cellDidTap: self.tableViews.map { $0.rx.modelSelected(Schedule.self).asObservable() },
            cellDelete: self.tableViews.map { $0.rx.modelDeleted(Schedule.self).map { $0.id! } },
            addButtonDidTap: self.addBarButton.rx.tap.asObservable()
        )

        guard  let output = self.viewModel?.transform(input: input, disposeBag: self.bag) else {
            return
        }

        output.scheduleLists.enumerated().forEach { index, observable in
            observable.asDriver()
                .drive(
                    self.tableViews[index].rx.items(
                        cellIdentifier: "ScheduleListCell",
                        cellType: ScheduleListCell.self
                    )
                ) { _, item, cell in
                    cell.configureContent(with: item)
                }
                .disposed(by: bag)
        }
    }
}

// MARK: - TableView Delegate Method

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
