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
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        test()
        setTaskHistoryConstraint()
        collectionViewConfigure()
    }
    
    private func test() {
        guard let popoverController = popoverPresentationController else {
            return
        }
        popoverController.sourceView = taskHistoryCollectionView
        guard let sourceView = popoverController.sourceView else {
            return
        }
        popoverController.sourceRect = CGRect(x: 10, y: 10, width: 300, height: 300)
        popoverController.backgroundColor = .red
        sourceView.backgroundColor = .yellow
        
    }
    
    private func collectionViewConfigure() {
        self.taskHistoryCollectionView.dataSource = self
        self.taskHistoryCollectionView.delegate = self
        self.popoverPresentationController?.delegate = self
    }
    
    private func setTaskHistoryConstraint() {
        self.view.addSubview(taskHistoryCollectionView)
        
        NSLayoutConstraint.activate([
            self.taskHistoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Style.taskHistoryMargin.left),
            self.taskHistoryCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: Style.taskHistoryMargin.top),
            self.taskHistoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Style.taskHistoryMargin.right),
            self.taskHistoryCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Style.taskHistoryMargin.bottom)
        ])
    }
}

extension TaskHistoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = taskHistoryCollectionView.dequeueReusableCell(withReuseIdentifier: TaskHistoryCollecionViewCell.identifier, for: indexPath) as? TaskHistoryCollecionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureCell()
        
        return cell
    }
    
    
}

extension TaskHistoryViewController: UICollectionViewDelegate {
    
}

extension TaskHistoryViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    
    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        popoverPresentationController.containerView?.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
}

extension TaskHistoryViewController: UIPopoverBackgroundViewMethods {
    static func arrowBase() -> CGFloat {
        return CGFloat(200)
    }
    
    static func contentViewInsets() -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    static func arrowHeight() -> CGFloat {
        return CGFloat(300)
    }
    
    
}
