//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    
    let toDoViewModel = TaskViewModel()
    let doingViewModel = TaskViewModel()
    let doneViewModel = TaskViewModel()
    let toDoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let doingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let doneCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Project Manager"
        let safeArea = self.view.safeAreaLayoutGuide
        self.addSubviewInView()
        self.registerCollectionViewCell()
        self.setUpDelegate()
        self.setUpDataSource()
        self.setUpToDoCollectionView(layoutGuide: safeArea)
        self.setUpDoingCollectionView(layoutGuide: safeArea)
        self.setUpDoneCollectionView(layoutGuide: safeArea)
    }
    
    private func addSubviewInView() {
        self.view.addSubview(toDoCollectionView)
        self.view.addSubview(doingCollectionView)
        self.view.addSubview(doneCollectionView)
    }
    
    private func registerCollectionViewCell() {
        self.toDoCollectionView.register(TaskCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: TaskCollectionViewCell.identifier)
        self.doingCollectionView.register(TaskCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: TaskCollectionViewCell.identifier)
        self.doneCollectionView.register(TaskCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: TaskCollectionViewCell.identifier)
    }
    
    private func setUpDelegate() {
        self.toDoCollectionView.delegate = self
        self.doingCollectionView.delegate = self
        self.doneCollectionView.delegate = self
    }
    
    private func setUpDataSource() {
        self.toDoCollectionView.dataSource = self
        self.doingCollectionView.dataSource = self
        self.doneCollectionView.dataSource = self
    }
    
    private func setUpToDoCollectionView(layoutGuide: UILayoutGuide) {
        self.toDoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.toDoCollectionView.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 10),
            self.toDoCollectionView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: 10),
            self.toDoCollectionView.widthAnchor.constraint(equalTo: layoutGuide.widthAnchor, multiplier: 1/3, constant: -40/3),
            self.toDoCollectionView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: 10),
        ])
    }
    
    private func setUpDoingCollectionView(layoutGuide: UILayoutGuide) {
        self.doingCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.doingCollectionView.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 10),
            self.doingCollectionView.leadingAnchor.constraint(equalTo: toDoCollectionView.trailingAnchor, constant: 10),
            self.doingCollectionView.widthAnchor.constraint(equalTo: layoutGuide.widthAnchor, multiplier: 1/3, constant: -40/3),
            self.doingCollectionView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: 10),
        ])
    }
    
    private func setUpDoneCollectionView(layoutGuide: UILayoutGuide) {
        self.doneCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.doneCollectionView.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 10),
            self.doneCollectionView.leadingAnchor.constraint(equalTo: doingCollectionView.trailingAnchor, constant: 10),
            self.doneCollectionView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -10),
            self.doneCollectionView.widthAnchor.constraint(equalTo: layoutGuide.widthAnchor, multiplier: 1/3, constant: -40/3),
            self.doneCollectionView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: 10),
        ])
    }
}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.toDoCollectionView {
            return toDoViewModel.taskListCount()
        }
        
        if collectionView == self.doingCollectionView {
            return doingViewModel.taskListCount()
        }
        
        return doneViewModel.taskListCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = toDoCollectionView.dequeueReusableCell(withReuseIdentifier: TaskCollectionViewCell.identifier, for: indexPath) as? TaskCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if collectionView == self.toDoCollectionView {
            cell.configureCell(with: Task(taskTitle: "toDoCollectionView", taskDescription: "toDoCollectionView", taskDeadline: "toDoCollectionView"))
            return cell
        }
        
        if collectionView == self.doingCollectionView {
            cell.configureCell(with: Task(taskTitle: "doingCollectionView", taskDescription: "doingCollectionView", taskDeadline: "doingCollectionView"))
            return cell
        }
        
        cell.configureCell(with: Task(taskTitle: "doneCollectionView", taskDescription: "doneCollectionView", taskDeadline: "doneCollectionView"))
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width
        let estimatedHeight: CGFloat = 500.0
        let dummyCell = TaskCollectionViewCell(frame: CGRect(x: 0, y: 0, width: width, height: estimatedHeight))
        if let task = self.findTask(collectionView: collectionView, indexPath: indexPath) {
            dummyCell.configureCell(with: task)
        }
        dummyCell.layoutIfNeeded()
        let estimatedSize = dummyCell.systemLayoutSizeFitting(CGSize(width: width, height: estimatedHeight))
        return CGSize(width: width, height: estimatedSize.height)
    }
    
    private func findTask(collectionView: UICollectionView, indexPath:IndexPath) -> Task? {
        switch collectionView {
        case toDoCollectionView:
            return toDoViewModel.referTask(at: indexPath)
        case doingCollectionView:
            return doingViewModel.referTask(at: indexPath)
        case doneCollectionView:
            return doneViewModel.referTask(at: indexPath)
        default:
            return nil
        }
    }
}




