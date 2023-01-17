//
//  ProjectManager - ListViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class ListViewController: UIViewController {
    
    typealias Text = Constant.Text
    typealias Style = Constant.Style
    typealias Color = Constant.Color

    var viewModel: ListViewModel?
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = Color.listViewSpacing
        stackView.axis = .horizontal
        stackView.spacing = Style.stackViewSpacing
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUIComponent()
    }

    private func configureUIComponent() {
        configureNavigationBar()
        configureViewHierarchy()
        configureLayoutConstraint()
    }

    private func configureNavigationBar() {
        navigationItem.title = Text.navigationTitle
        navigationItem.rightBarButtonItem = addPlanButton()
    }

    private func configureViewHierarchy() {
        view.addSubview(stackView)
        State.allCases.forEach { state in
            let listView = ListView(state: state,
                                    layout: createListLayout(),
                                    frame: .zero)
            listView.setDataSource(self)
            listView.setDelegate(self)
            stackView.addArrangedSubview(listView)
        }
    }

    private func configureLayoutConstraint() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                              constant: Style.stackViewBottomInset),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }

    private func presentDetailView(viewModel: PlanViewModel? = nil) {
        let planViewController = PlanViewController()
        if let viewModel = viewModel {
            planViewController.viewModel = viewModel
        }

        planViewController.modalPresentationStyle = .formSheet
        present(planViewController, animated: true)
    }

    private func addPlanAction() -> UIAction {
        let action = UIAction { _ in
            self.presentDetailView(viewModel: ProjectViewModel())
        }

        return action
    }

    private func addPlanButton() -> UIBarButtonItem {
        let button = UIBarButtonItem(systemItem: .add, primaryAction: addPlanAction())

        return button
    }

    private func createListLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
}

extension ListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let listCollectionView = collectionView as? ListCollectionView,
              let count = viewModel?.fetchList(of: listCollectionView.state).count else {
            return .zero
        }

        return count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellType: ListCell.self, for: indexPath)
        guard let listCollectionView = collectionView as? ListCollectionView,
              let list = viewModel?.fetchList(of: listCollectionView.state) else {
                  return cell
              }
        let project = list[indexPath.item]
        guard let texts = viewModel?.convertToText(from: project) else {
            return cell
        }
        cell.configure(title: texts.title,
                       description: texts.description,
                       deadline: texts.deadline,
                       isOverDue: project.deadline.isOverdue)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ListHeaderReusableView", for: indexPath)
            return headerView
        default:
            preconditionFailure("footer는 지원하지 않습니다.")
        }
    }
}
