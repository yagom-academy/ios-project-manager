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
    
    private func setUpUI() {
        let safeArea = self.contentView.safeAreaLayoutGuide
        self.addSubviewInContentView()
        self.setUpTaskTitleLabel(layoutGuide: safeArea)
        self.setUpTaskDescriptionLabel(layoutGuide: safeArea)
        self.setUpTaskDeadlineLabel(layoutGuide: safeArea)
    }
    
    private func addSubviewInContentView() {
        self.contentView.addSubview(taskTitle)
        self.contentView.addSubview(taskDescription)
        self.contentView.addSubview(taskDeadline)
    }
    
    private func setUpTaskTitleLabel(layoutGuide: UILayoutGuide) {
        taskTitle.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title3)
        taskTitle.textColor = .label
        taskTitle.translatesAutoresizingMaskIntoConstraints = false
        taskTitle.numberOfLines = 1
        NSLayoutConstraint.activate([
            taskTitle.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 5),
            taskTitle.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: 10),
            taskTitle.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -10),
            taskTitle.bottomAnchor.constraint(equalTo: taskDescription.topAnchor, constant: -5),
        ])
    }
    
    private func setUpTaskDescriptionLabel(layoutGuide: UILayoutGuide) {
        taskDescription.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        taskDescription.textColor = .label
        taskDescription.translatesAutoresizingMaskIntoConstraints = false
        taskDescription.numberOfLines = 3
        NSLayoutConstraint.activate([
            taskDescription.topAnchor.constraint(equalTo: taskTitle.bottomAnchor, constant: 5),
            taskDescription.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: 10),
            taskDescription.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -10),
            taskDescription.bottomAnchor.constraint(equalTo: taskDeadline.topAnchor, constant: -5),
        ])
    }
    
    private func setUpTaskDeadlineLabel(layoutGuide: UILayoutGuide) {
        taskDeadline.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.footnote)
        taskDeadline.textColor = .label
        taskDeadline.translatesAutoresizingMaskIntoConstraints = false
        taskDeadline.numberOfLines = 1
        NSLayoutConstraint.activate([
            taskDeadline.topAnchor.constraint(equalTo: taskDescription.bottomAnchor, constant: 5),
            taskDeadline.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: 10),
            taskDeadline.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -10),
            taskDeadline.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -5),
        ])
    }
    
    func configureCell(with: Task) {
        setUpUI()
        self.contentView.backgroundColor = UIColor.red
        taskTitle.text = with.taskTitle
        taskDescription.text = with.taskDescription
        taskDeadline.text = with.taskDeadline
    }
}
