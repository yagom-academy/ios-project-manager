//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import RxSwift
import RxCocoa

private enum Design {
    static let stackViewSpacing = 8.0
    static let addBarButtonImage = UIImage(systemName: "plus")
    static let navigationBarTitle = "Project Manager"
    static let stackViewBottomAnchorConstant = -30.0
    static let tableHeaderViewHeight = 45.0
    static let stackViewBackgroundColor = UIColor.systemGray4
    static let viewBackgroundColor = UIColor.systemGray5
    static let tableViewBackgroundColor = UIColor.systemGray6
}

final class MainViewController: UIViewController {

    // MARK: - Properties
    var viewModel: MainViewModel?
    private let bag = DisposeBag()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = Design.stackViewSpacing
        stackView.weakShadow()
        stackView.backgroundColor = Design.stackViewBackgroundColor
        return stackView
    }()

    private let addBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.image = Design.addBarButtonImage
        return barButton
    }()

    private let tableViews: [UITableView] = Progress.allCases.map { _ in UITableView() }
    private let headerViews: [ScheduleListHeaderView] = Progress.allCases.map { progress in
        let headerView = ScheduleListHeaderView()
        headerView.progressLabel.text = progress.description.uppercased()
        return headerView
    }

    private let longPressGestureRecognizers: [UILongPressGestureRecognizer] = Progress.allCases
        .map { _ in UILongPressGestureRecognizer() }

    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configure()
    }
}

// MARK: - Private Methods

private extension MainViewController {

    func configure() {
        self.view.backgroundColor = Design.viewBackgroundColor
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
        self.tableViews.forEach(self.stackView.addArrangedSubview)
    }

    func configureNavigationBar() {
        self.title = Design.navigationBarTitle
        self.navigationItem.rightBarButtonItem = addBarButton
    }

    func configureConstraint() {
        let safeAreaLayoutGuide = self.view.safeAreaLayoutGuide
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            self.stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            self.stackView.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor,
                constant: Design.stackViewBottomAnchorConstant
            )
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
            tableView.backgroundColor = Design.tableViewBackgroundColor
            tableView.separatorStyle = .none
            tableView.tableHeaderView = self.headerViews[safe: index]
            tableView.tableHeaderView?.frame.size.height = Design.tableHeaderViewHeight
        }

        self.configureTableViewGestureRecognizers()
    }

    func configureTableViewGestureRecognizers() {
        self.tableViews.enumerated().forEach { index, tableView in
            guard let longRecognizer = self.longPressGestureRecognizers[safe: index] else {
                return
            }

            tableView.addGestureRecognizer(longRecognizer)
        }
    }

    func binding() {
        let input = self.setInput()
        guard let output = self.viewModel?.transform(input: input, disposeBag: self.bag) else {
            return
        }

        self.bindingOutput(for: output)
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

    func bindingOutput(for output: MainViewModel.Output) {
        output.scheduleLists.enumerated().forEach { index, observable in
            guard let tableView = self.tableViews[safe: index] else { return }
            observable
                .do(onNext: { self.setHeaderViewButtonTitle(for: $0.count, at: index) })
                .asDriver(onErrorJustReturn: [])
                .drive(
                    tableView.rx.items(
                        cellIdentifier: String(describing: ScheduleListCell.self),
                        cellType: ScheduleListCell.self
                    )
                ) { _, item, cell in
                    cell.configureContent(with: item)
                }
                .disposed(by: bag)
        }
    }

    func setHeaderViewButtonTitle(for number: Int, at index: Int) {
        self.headerViews[safe: index]?.countButton.setTitle("\(number)", for: .normal)
    }

    func cellAndSchedule(
        from gestureRecognizer: UIGestureRecognizer
    ) throws -> (UITableViewCell, Schedule)? {
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
