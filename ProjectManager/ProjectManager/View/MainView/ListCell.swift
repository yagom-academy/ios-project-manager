//
//  ListCell.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/13.
//

import UIKit

final class ListCell: UITableViewCell {
    
    static let identifier = "projectCell"
    
    private(set) var projectViewModel: ProjectViewModel? {
        didSet {
            setupTitleLabelText()
            setupDateLabelText()
            setupDetailLabelText()
        }
    }
    private var titleLabel = UILabel(font: .title3)
    private var detailLabel = UILabel(font: .body, textColor: .systemGray2, numberOfLines: 3)
    private var dateLabel = UILabel(font: .body, numberOfLines: 0)
    private var stackView = UIStackView(axis: .vertical,
                                        distribution: .fill,
                                        alignment: .leading,
                                        spacing: Default.stackSpacing,
                                        backgroundColor: .tertiarySystemBackground,
                                        margin: Default.margin,
                                        cornerRadius: Default.radius)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemGroupedBackground
        configureHierarchy()
        configureLayout()
        registerLongPressGestureRecognizer()
    }
    
    func setupViewModel(_ projectViewModel: ProjectViewModel) {
        self.projectViewModel = projectViewModel
    }
    
    private func setupTitleLabelText() {
        titleLabel.text = projectViewModel?.project.title
    }
    
    private func setupDetailLabelText() {
        detailLabel.text = projectViewModel?.project.detail
    }
    
    private func setupDateLabelText() {
        guard let date = projectViewModel?.project.date else { return }
        
        dateLabel.text = date.changeDotFormatString()
        
        if date.isPast() {
            dateLabel.textColor = .red
        } else {
            dateLabel.textColor = .black
        }
    }

    private func registerLongPressGestureRecognizer() {
        let longPressGesture = UILongPressGestureRecognizer(target: self,
                                                            action: #selector(notifyLongPressed))
        longPressGesture.delaysTouchesBegan = true
        
        self.contentView.addGestureRecognizer(longPressGesture)
    }
    
    @objc private func notifyLongPressed(_ sender: UILongPressGestureRecognizer) {
        guard let projectViewModel = projectViewModel else { return }
        
        NotificationCenter.default.post(name: Notification.Name("cellLongPressed"),
                                        object: sender.view,
                                        userInfo: ["project": projectViewModel.project,
                                                   "state": projectViewModel.state])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout
extension ListCell {
    
    private func configureHierarchy() {
        [titleLabel, detailLabel, dateLabel].forEach { label in
            stackView.addArrangedSubview(label)
        }
        contentView.addSubview(stackView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                               constant: Default.margin),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                constant: -Default.margin),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                           constant: Default.margin),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                              constant: -Default.margin)
        ])
    }
}

// MARK: - NameSpace
extension ListCell {
    
    private enum Default {
        
        static let radius: CGFloat = 10
        static let stackSpacing: CGFloat = 5
        static let margin: CGFloat = 10
    }
}
