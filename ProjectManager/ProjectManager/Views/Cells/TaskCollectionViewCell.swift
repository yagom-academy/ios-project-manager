//
//  TaskCollectionViewCell.swift
//  ProjectManager
//
//  Created by 최정민 on 2021/07/18.
//

import Foundation
import UIKit

class TaskCollectionViewCell: UICollectionViewCell {
    static let identifier = "TaskCollectionViewCell"
    var taskTitle = UILabel()
    var taskDescription = UILabel()
    var taskDeadline = UILabel()
    var swipeView = UIView()
    var deleteButton: UIButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func commonInit() {
        self.setUpUI()
    }
    
    @objc func deleteTask() {
        let collectionView: UICollectionView = self.superview as! UICollectionView
        let indexPath: IndexPath = collectionView.indexPathForItem(at: self.center)!
        print("collectionView: ", collectionView)
        print("indexPath: ", indexPath)
        
    }
    
    private func setUpUI() {
        self.contentView.backgroundColor = UIColor.red
        let swipeViewSafeArea = self.swipeView.safeAreaLayoutGuide
        let contentViewSafeArea = self.contentView.safeAreaLayoutGuide
        self.addSubviewInContentView()
        self.setUpSwipeView(layoutGuide: contentViewSafeArea)
        self.setUpDeleteButton(layoutGuide: contentViewSafeArea)
        self.setUpTaskTitleLabel(layoutGuide: swipeViewSafeArea)
        self.setUpTaskDescriptionLabel(layoutGuide: swipeViewSafeArea)
        self.setUpTaskDeadlineLabel(layoutGuide: swipeViewSafeArea)
    }
    
    private func addSubviewInContentView() {
        self.contentView.addSubview(self.taskTitle)
        self.contentView.addSubview(self.taskDescription)
        self.contentView.addSubview(self.taskDeadline)
    }
    
    private func setUpSwipeView(layoutGuide: UILayoutGuide) {
        self.swipeView.backgroundColor = .white
        self.swipeView.addSubview(self.taskTitle)
        self.swipeView.addSubview(self.taskDescription)
        self.swipeView.addSubview(self.taskDeadline)
        self.swipeView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.swipeView.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 0),
            self.swipeView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: 0),
            self.swipeView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: 0),
            self.swipeView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: 0),
        ])
    }
    
    private func setUpDeleteButton(layoutGuide: UILayoutGuide) {
        self.deleteButton.setTitle("Delete", for: .normal)
        self.deleteButton.setTitleColor(.white, for: .normal)
        self.deleteButton.backgroundColor = .red
        self.deleteButton.addTarget(self, action: #selector(deleteTask), for: .touchDown)
        self.deleteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.deleteButton.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 0),
            self.deleteButton.leadingAnchor.constraint(equalTo: self.swipeView.trailingAnchor, constant: 0),
            self.deleteButton.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: 0),
        ])
    }
    
    private func setUpTaskTitleLabel(layoutGuide: UILayoutGuide) {
        self.taskTitle.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title3)
        self.taskTitle.textColor = .label
        self.taskTitle.translatesAutoresizingMaskIntoConstraints = false
        self.taskTitle.numberOfLines = 1
        NSLayoutConstraint.activate([
            self.taskTitle.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 5),
            self.taskTitle.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: 10),
            self.taskTitle.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -10),
            self.taskTitle.bottomAnchor.constraint(equalTo: self.taskDescription.topAnchor, constant: -5),
        ])
    }
    
    private func setUpTaskDescriptionLabel(layoutGuide: UILayoutGuide) {
        self.taskDescription.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        self.taskDescription.textColor = .label
        self.taskDescription.translatesAutoresizingMaskIntoConstraints = false
        self.taskDescription.numberOfLines = 3
        NSLayoutConstraint.activate([
            self.taskDescription.topAnchor.constraint(equalTo: self.taskTitle.bottomAnchor, constant: 5),
            self.taskDescription.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: 10),
            self.taskDescription.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -10),
            self.taskDescription.bottomAnchor.constraint(equalTo: self.taskDeadline.topAnchor, constant: -5),
        ])
    }
    
    private func setUpTaskDeadlineLabel(layoutGuide: UILayoutGuide) {
        self.taskDeadline.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.footnote)
        self.taskDeadline.textColor = .label
        self.taskDeadline.translatesAutoresizingMaskIntoConstraints = false
        self.taskDeadline.numberOfLines = 1
        NSLayoutConstraint.activate([
            self.taskDeadline.topAnchor.constraint(equalTo: self.taskDescription.bottomAnchor, constant: 5),
            self.taskDeadline.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: 10),
            self.taskDeadline.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -10),
            self.taskDeadline.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -5),
        ])
    }
    
    func configureCell(with: Task) {
        self.taskTitle.text = with.taskTitle
        self.taskDescription.text = with.taskDescription
        self.taskDeadline.text = with.taskDeadline
    }
}
