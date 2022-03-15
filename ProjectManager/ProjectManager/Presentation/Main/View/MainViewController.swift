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

    private let popoverView = PopoverView()
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
        self.view.addSubview(self.stackView)
        self.tableViews.forEach(self.stackView.addArrangedSubview)
    }

    func configureNavigationBar() {
        self.title = Design.navigationBarTitle
        self.navigationItem.rightBarButtonItem = self.addBarButton
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

    func configureTableView() {
        self.tableViews.enumerated().forEach { index, tableView in
            tableView.register(cellWithClass: ScheduleListCell.self)
            tableView.backgroundColor = Design.tableViewBackgroundColor
            tableView.separatorStyle = .none
            tableView.tableHeaderView = self.headerViews[safe: index]
            tableView.tableHeaderView?.frame.size.height = Design.tableHeaderViewHeight
            tableView.rx.itemSelected
                .subscribe(onNext: { tableView.deselectRow(at: $0, animated: true) })
                .disposed(by: self.bag)
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
            tableViewLongPressed: Observable.merge(self.longPressGestureRecognizers.enumerated().map { index, gesture in
                gesture.rx.event
                    .map(self.schedule(from:))
                    .compactMap { $0 }
                    .map { ($0.0, $0.1, index) }
            })
            ,
            cellDidTap: self.tableViews.map { $0.rx.modelSelected(Schedule.self).asObservable() },
            cellDelete: self.tableViews.map { $0.rx.modelDeleted(Schedule.self).map { $0.id } },
            addButtonDidTap: self.addBarButton.rx.tap.asObservable(),
            popoverTopButtonDidTap: self.popoverView.topButton.rx.tap.asObservable()
                .do(onNext: self.dismissPopover),
            popoverBottomButtonDidTap: self.popoverView.bottomButton.rx.tap.asObservable()
                .do(onNext: self.dismissPopover)
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
                .disposed(by: self.bag)
        }

        output.popoverShouldPresent
                .subscribe(onNext: { indexPath, index in
                    guard let tableView = self.tableViews[safe: index] else { return }
                    guard let cell = tableView.cellForRow(at: indexPath) else {
                        return
                    }
                    self.presentPopover(at: cell)
                })
                .disposed(by: self.bag)

        output.popoverTopButtonTitle
            .asDriver(onErrorJustReturn: .empty)
                .drive(self.popoverView.topButton.rx.title())
                .disposed(by: self.bag)

        output.popoverBottomButtonTitle
            .asDriver(onErrorJustReturn: .empty)
                .drive(self.popoverView.bottomButton.rx.title())
                .disposed(by: self.bag)

    }

    func setHeaderViewButtonTitle(for number: Int, at index: Int) {
        self.headerViews[safe: index]?.countButton.setTitle("\(number)", for: .normal)
    }

    func schedule(
        from gestureRecognizer: UIGestureRecognizer
    ) throws -> (Schedule, IndexPath)? {
        guard let tableView = gestureRecognizer.view as? UITableView else {
            return nil
        }

        if gestureRecognizer.state == .began {
            let touchPoint = gestureRecognizer.location(in: tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                return (try tableView.rx.model(at: indexPath), indexPath)
            }
        }
        return nil
    }

    func presentPopover(at sourceView: UIView) {
        let popoverViewController: UIViewController = {
            let viewController = UIViewController()
            viewController.view = self.popoverView
            viewController.modalPresentationStyle = .popover
            viewController.preferredContentSize = CGSize(width: 230, height: 100)
            viewController.popoverPresentationController?.permittedArrowDirections = [.up, .down]
            viewController.popoverPresentationController?.sourceView = sourceView
            return viewController
        }()

        self.present(popoverViewController, animated: true)
    }

    func dismissPopover() {
        self.presentedViewController?.dismiss(animated: true, completion: nil)
    }
}
