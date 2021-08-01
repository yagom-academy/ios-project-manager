//
//  TaskHistoryViewController.swift
//  ProjectManager
//
//  Created by Fezravien on 2021/07/30.
//

import UIKit

final class TaskHistoryViewController: UIViewController {

    enum Style {
        static let taskHistoryMargin: UIEdgeInsets = .init(top: 22, left: 10, bottom: -10, right: -10)
    }

    private let taskHistoryCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.register(TaskHistoryCollecionViewCell.self, forCellWithReuseIdentifier: TaskHistoryCollecionViewCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    var taskHistoryDelegate: TaskHistoryDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray5
        self.view.alpha = 0.5
        setTaskHistoryConstraint()
        collectionViewConfigure()
    }

    private func collectionViewConfigure() {
        self.taskHistoryCollectionView.dataSource = self
        self.taskHistoryCollectionView.delegate = self
    }

    private func setTaskHistoryConstraint() {
        self.view.addSubview(taskHistoryCollectionView)
        let layoutConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
        taskHistoryCollectionView.collectionViewLayout = listLayout

        NSLayoutConstraint.activate([
            self.taskHistoryCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Style.taskHistoryMargin.left),
            self.taskHistoryCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: Style.taskHistoryMargin.top),
            self.taskHistoryCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: Style.taskHistoryMargin.right),
            self.taskHistoryCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: Style.taskHistoryMargin.bottom)
        ])
    }
}

extension TaskHistoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return taskHistoryDelegate?.historyCount() ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = taskHistoryCollectionView.dequeueReusableCell(withReuseIdentifier: TaskHistoryCollecionViewCell.identifier, for: indexPath) as? TaskHistoryCollecionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(data: taskHistoryDelegate?.referHistory(index: indexPath) ?? TaskHistory(title: "", date: Date()))

        return cell
    }
}

extension TaskHistoryViewController: UICollectionViewDelegate {

}

extension TaskHistoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let estimatedHeight: CGFloat = 200.0
        let width = collectionView.frame.width
        let cell = TaskHistoryCollecionViewCell(frame: CGRect(x: 0, y: 0, width: width, height: 400))
        cell.configureCell(data: taskHistoryDelegate?.referHistory(index: indexPath) ?? TaskHistory(title: "", date: Date()))
        cell.layoutIfNeeded()
        let estumatedSize = cell.systemLayoutSizeFitting(CGSize(width: width, height: estimatedHeight))
        return CGSize(width: width, height: estumatedSize.height)
    }
}

extension TaskHistoryViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }


    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        popoverPresentationController.containerView?.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
}

