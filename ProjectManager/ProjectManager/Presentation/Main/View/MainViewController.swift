//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import RxSwift
import RxCocoa

final class MainViewController: UIViewController, UIGestureRecognizerDelegate {

// MARK: - Properties
    var viewModel: MainViewModel?

    private let bag = DisposeBag()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 7.0
        stackView.weakShadow()
        stackView.backgroundColor = .systemGray4
        return stackView
    }()
    private let tableViews: [UITableView] = Progress.allCases.map { _ in UITableView(frame: .zero, style: .plain) }
    private let addBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.title = "+"
        return barButton
    }()
    private let longPressGestureRecognizers: [UILongPressGestureRecognizer] = Progress.allCases.map { _ in
        let longPressGestureRecognizer = UILongPressGestureRecognizer()
        longPressGestureRecognizer.minimumPressDuration = 0.7
        return longPressGestureRecognizer
    }

    private let headerViews: [ScheduleListHeaderView] = Progress.allCases.map { progress in
        let headerView = ScheduleListHeaderView()
        headerView.progressLabel.text = progress.description.uppercased()
        return headerView
    }

// MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configure()
    }

    override func viewWillAppear(_ animated: Bool) {


    }
}

// MARK: - Private Methods

private extension MainViewController {

    func configure() {
        self.view.backgroundColor = .systemGray5
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
            self.stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30),
        ])
    }

    @objc
    func longPress(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {
        guard let tableView = longPressGestureRecognizer.view as? UITableView else {
            return
        }
        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {
            let touchPoint = longPressGestureRecognizer.location(in: tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }

    func configureTableView() {
        self.tableViews.enumerated().forEach { index, tableView in
            tableView.register(cellWithClass: ScheduleListCell.self)
            tableView.delegate = self
            tableView.backgroundColor = .systemGray6
            tableView.separatorStyle = .none
            tableView.tableHeaderView = self.headerViews[safe: index]
            tableView.tableHeaderView?.frame.size.height = 45
        }
        self.configureTableViewGestureRecognizers()
    }

    func configureTableViewGestureRecognizers() {
        self.tableViews.enumerated().forEach { index, tableView in
            guard let longRecognizer = self.longPressGestureRecognizers[safe: index] else { return }
            tableView.addGestureRecognizer(longRecognizer)
        }
    }

    func showActionSheet() {
        let actionSheet = UIAlertController(title: "이동", message: nil, preferredStyle: .actionSheet)
        let first = UIAlertAction(title: "Move to DOING", style: .default, handler: nil)
        let second = UIAlertAction(title: "Move to DONE", style: .default, handler: nil)
        actionSheet.addAction(first)
        actionSheet.addAction(second)
    }

    func binding() {
        let input = self.setInput()
        guard let output = self.viewModel?.transform(input: input, disposeBag: self.bag) else {
            return
        }

        self.bindingOutput(output: output)
    }

    func setInput() -> MainViewModel.Input {
        return MainViewModel.Input(
            viewWillAppear: self.rx.methodInvoked(#selector(UIViewController.viewWillAppear))
                .map { _ in },
            tableViewLongPressed: self.longPressGestureRecognizers.map { $0.rx.event
                .map(self.cellAndSchedule(from:)).asObservable()
            },
            cellDidTap: self.tableViews.map { $0.rx.modelSelected(Schedule.self).asObservable() },
            cellDelete: self.tableViews.map { $0.rx.modelDeleted(Schedule.self).map { $0.id } },
            addButtonDidTap: self.addBarButton.rx.tap.asObservable()
        )
    }

    func bindingOutput(output: MainViewModel.Output) {
        output.scheduleLists.enumerated().forEach { index, observable in
            guard let tableView = self.tableViews[safe: index] else { return }
            observable
                .do(onNext: { schedule in
                    self.headerViews[safe: index]?.countButton.setTitle("\(schedule.count)", for: .normal)
                })
                .asDriver(onErrorJustReturn: [])
                .drive(
                    tableView.rx.items(
                        cellIdentifier: "ScheduleListCell",
                        cellType: ScheduleListCell.self
                    )
                ) { _, item, cell in
                    cell.configureContent(with: item)
                }
                .disposed(by: bag)
        }
    }

    private func cellAndSchedule(from gestureRecognizer: UIGestureRecognizer) throws -> (UITableViewCell, Schedule)? {
        guard let tableView = gestureRecognizer.view as? UITableView else {
            return nil
        }

        if gestureRecognizer.state == .began {
            let touchPoint = gestureRecognizer.location(in: tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                guard let cell = tableView.cellForRow(at: indexPath) else { fatalError() }
                return (cell, try tableView.rx.model(at: indexPath))
            }
        }
        return nil
    }
}

// MARK: - TableView Delegate Method

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
