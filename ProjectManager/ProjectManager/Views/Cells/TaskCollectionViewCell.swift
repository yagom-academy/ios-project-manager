//
//  TaskCollectionViewCell.swift
//  ProjectManager
//
//  Created by 최정민 on 2021/07/18.
//

import Foundation
import UIKit

final class TaskCollectionViewCell: UICollectionViewCell {
    static let identifier = "TaskCollectionViewCell"
    
    enum Style {
        static let titleLabelMargin: UIEdgeInsets = .init(top: 5, left: 10, bottom: -5, right: -10)
        static let descriptionLabelMargin: UIEdgeInsets = .init(top: 5, left: 10, bottom: -5, right: -10)
        static let deadLineLabelMargin: UIEdgeInsets = .init(top: 5, left: 10, bottom: -5, right: -10)
    }
    
    private let taskTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .label
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let taskDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .label
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let taskDeadline: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.textColor = .label
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let swipeView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 17
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private var panGestureRecognizer: UIPanGestureRecognizer!
    private var estimatedSize: CGSize = CGSize(width: 0, height: 0)
    private var isDragged = false
    private var taskID: String = ""
    var deleteDelegate: DeleteDelegate?
    
    // MARK: - Initial TaskCollectionViewCell
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setPanGestureRecognizer()
        setTaskCollectionViewCell()
        setContentConstraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - TaskCollecionViewCell Configure
    
    private func setPanGestureRecognizer() {
        self.panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        self.panGestureRecognizer.delegate = self
        self.addGestureRecognizer(self.panGestureRecognizer)
    }
    
    private func setTaskCollectionViewCell() {
        self.contentView.layer.cornerRadius = 15
        self.layer.cornerRadius = 15
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 1.0
        self.layer.shadowColor = UIColor.systemGray5.cgColor
    }
    
    private func setContentConstraint() {
        setSwipeView()
        setDeleteButton()
        setTaskTitleLabel()
        setTaskDescriptionLabel()
        setTaskDeadlineLabel()
    }
    
    // MARK: - Constraint
    
    private func setSwipeView() {
        self.contentView.addSubview(self.swipeView)
        self.swipeView.addSubview(self.taskTitle)
        self.swipeView.addSubview(self.taskDescription)
        self.swipeView.addSubview(self.taskDeadline)
        NSLayoutConstraint.activate([
            self.swipeView.topAnchor.constraint(equalTo: contentView.topAnchor),
            self.swipeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            self.swipeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            self.swipeView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setDeleteButton() {
        self.contentView.addSubview(self.deleteButton)
        self.contentView.bringSubviewToFront(swipeView)
        self.deleteButton.addTarget(self, action: #selector(deleteTask), for: .touchUpInside)
        NSLayoutConstraint.activate([
            self.deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            self.deleteButton.trailingAnchor.constraint(equalTo: self.swipeView.trailingAnchor),
            self.deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    private func setTaskTitleLabel() {
        NSLayoutConstraint.activate([
            self.taskTitle.topAnchor.constraint(equalTo: swipeView.topAnchor, constant: Style.titleLabelMargin.top),
            self.taskTitle.leadingAnchor.constraint(equalTo: swipeView.leadingAnchor, constant: Style.titleLabelMargin.left),
            self.taskTitle.trailingAnchor.constraint(equalTo: swipeView.trailingAnchor, constant: Style.titleLabelMargin.right),
            self.taskTitle.bottomAnchor.constraint(equalTo: self.taskDescription.topAnchor, constant: Style.titleLabelMargin.bottom),
        ])
    }
    
    private func setTaskDescriptionLabel() {
        NSLayoutConstraint.activate([
            self.taskDescription.topAnchor.constraint(equalTo: self.taskTitle.bottomAnchor, constant: Style.descriptionLabelMargin.top),
            self.taskDescription.leadingAnchor.constraint(equalTo: swipeView.leadingAnchor, constant: Style.descriptionLabelMargin.left),
            self.taskDescription.trailingAnchor.constraint(equalTo: swipeView.trailingAnchor, constant: Style.descriptionLabelMargin.right),
            self.taskDescription.bottomAnchor.constraint(equalTo: self.taskDeadline.topAnchor, constant: Style.descriptionLabelMargin.bottom),
        ])
    }
    
    private func setTaskDeadlineLabel() {
        NSLayoutConstraint.activate([
            self.taskDeadline.topAnchor.constraint(equalTo: self.taskDescription.bottomAnchor, constant: Style.deadLineLabelMargin.top),
            self.taskDeadline.leadingAnchor.constraint(equalTo: swipeView.leadingAnchor, constant: Style.deadLineLabelMargin.left),
            self.taskDeadline.trailingAnchor.constraint(equalTo: swipeView.trailingAnchor, constant: Style.deadLineLabelMargin.right),
            self.taskDeadline.bottomAnchor.constraint(equalTo: swipeView.bottomAnchor, constant: Style.deadLineLabelMargin.bottom),
        ])
    }
    
    // MARK: - Convert Date
        
    private func convertStringToTimeInterval1970(date: String) -> Double? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.dateFormat = "yyyy.MM.dd"
        dateFormatter.timeZone = TimeZone.current
        guard let dateInDateFormat = dateFormatter.date(from: date) else { return nil }
        
        return dateInDateFormat.timeIntervalSince1970
    }
    
    private func convertDateToString(_ date: Date) -> String {
        let dateFormatter =  DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: date)
    }

    
    private func checkIfDeadlineHasPassed(deadline: String) -> Bool? {
        guard let deadline = convertStringToTimeInterval1970(date: deadline) else { return nil }
        return Date().timeIntervalSince1970 > deadline + 86400 ? true : false
    }
    
    // MARK: - Outside Methd - initial Cell Configure
    
    func configureCell(data: Task) {
        self.taskTitle.text = data.taskTitle
        self.taskDescription.text = data.taskDescription
        self.taskDeadline.text = convertDateToString(data.taskDeadline)
        self.taskID = data.taskID
        self.swipeView.layoutIfNeeded()
        self.estimatedSize = self.swipeView.systemLayoutSizeFitting(sizeThatFits(CGSize(width: self.contentView.frame.width, height: 500.0)))
        self.deleteButton.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        guard let isDeadlinePassed = checkIfDeadlineHasPassed(deadline: convertDateToString(data.taskDeadline)) else { return }
        taskDeadline.textColor = .black
        if isDeadlinePassed {
            taskDeadline.textColor = .red
        }
    }
    
    // MARK: - Swipe Action
    
    private func closeSwipe() {
        UIView.animate(withDuration: 0.2) {
            self.swipeView.frame = CGRect(x:0, y: 0, width: self.contentView.frame.width, height: self.contentView.frame.height)
            self.deleteButton.frame = CGRect(x: self.contentView.frame.width, y: 0, width: 150, height: self.contentView.frame.height)
        }
    }
    
    @objc func deleteTask() {
        guard let collectionView: UICollectionView = self.superview as? UICollectionView,
              let indexPath = collectionView.indexPathForItem(at: self.center),
              let title = taskTitle.text else {
            
            return
        }

        deleteDelegate?.deleteTask(collectionView: collectionView, indexPath: indexPath, taskID: self.taskID, taskTitle: title)
    }
}

// MAKR: - GestureRecognizer Delegate - Swipe

extension TaskCollectionViewCell: UIGestureRecognizerDelegate {
    
    override func dragStateDidChange(_ dragState: UICollectionViewCell.DragState) {
            switch dragState {
            case .lifting:
                self.isDragged = true
            case .none:
                self.isDragged = false
            case .dragging:
                return
            default:
                return
            }
        }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if isDragged {
            return false
        }
        if (panGestureRecognizer.velocity(in: panGestureRecognizer.view)).x < 0 {
            return true
        }
        if self.swipeView.center.x < self.frame.width/2 && (panGestureRecognizer.velocity(in: panGestureRecognizer.view)).x > 0 {
            return true
        }
        return false
    }
    
    @objc func onPan(_ pan: UIPanGestureRecognizer) {
        self.swipeView.translatesAutoresizingMaskIntoConstraints = true
        self.deleteButton.translatesAutoresizingMaskIntoConstraints = true
        let transition = pan.translation(in: self.swipeView)
        var changedX = self.swipeView.center.x + transition.x
        
        if self.swipeView.center.x < self.frame.width/2 - 120 {
            changedX = self.frame.width/2 - 120
        }
        
        if self.swipeView.center.x > self.frame.width/2 {
            changedX = self.frame.width/2
        }
        
        UIView.animate(withDuration: 0.2) {
            self.deleteButton.frame = CGRect(x: changedX + self.contentView.frame.width/2, y: 0, width: 120, height: self.contentView.frame.height)
            self.panGestureRecognizer.setTranslation(CGPoint.zero, in: self.deleteButton)
            self.swipeView.center = CGPoint(x: changedX, y: self.swipeView.center.y)
            self.panGestureRecognizer.setTranslation(CGPoint.zero, in: self.swipeView)
        }
        
        if pan.state == UIGestureRecognizer.State.ended {
            if self.swipeView.center.x + 120/2 < contentView.center.x {
                UIView.animate(withDuration: 0.2) { [weak self] in
                    self?.swipeView.frame = CGRect(x: -(self?.deleteButton.frame.width)!, y: 0, width: (self?.contentView.frame.width)!, height: (self?.contentView.frame.height)!)
                    self?.deleteButton.frame = CGRect(x: (self?.contentView.frame.width)!-120, y: 0, width: 120, height: (self?.contentView.frame.height)!)
                }
                return
            }
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.swipeView.frame = CGRect(x: 0, y: 0, width: (self?.contentView.frame.width)!, height: (self?.contentView.frame.height)!)
                self?.deleteButton.frame = CGRect(x: (self?.contentView.frame.width)!-120, y: 0, width: 120, height: (self?.contentView.frame.height)!)
            }
        }
    }
}
