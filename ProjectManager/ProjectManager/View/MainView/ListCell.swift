//
//  ListCell.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/13.
//

import UIKit

class ListCell: UITableViewCell {
    
    static let identifier = "projectCell"
    
    weak var delegate: ListCellDelegate?
    
    var cellViewModel = ListCellViewModel(process: .todo)
    var titleLabel = UILabel(font: .title3)
    var descriptionLabel = UILabel(font: .body, textColor: .systemGray2, numberOfLines: 3)
    var dateLabel = UILabel(font: .body, numberOfLines: 0)
    var totalView = UIView(backgroundColor: .tertiarySystemBackground, cornerRadius: 10)
    var stack = UIStackView(axis: .vertical,
                            distribution: .fillProportionally,
                            alignment: .leading,
                            spacing: 5,
                            backgroundColor: .tertiarySystemBackground)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemGroupedBackground
        configureHierarchy()
        configureLayout()
        bidingViewModel()
        registerLongPressGestureRecognizer()
    }
    
    func bidingViewModel() {
        cellViewModel.updateTitleDate = { [weak self] data in
            self?.titleLabel.text = data
        }
        
        cellViewModel.updateDescriptionDate = { [weak self] data in
            self?.descriptionLabel.text = data
        }
        
        cellViewModel.updateDateDate = { [weak self] data, isMissDeadLine, process in
            self?.dateLabel.text = data
            
            guard isMissDeadLine && process != .done else { return }
            self?.dateLabel.textColor = .red
        }
    }
    
    func configureHierarchy() {
        [titleLabel, descriptionLabel, dateLabel].forEach {
            stack.addArrangedSubview($0)
        }
        
        totalView.addSubview(stack)
        contentView.addSubview(totalView)
    }
    
    func configureLayout() {
        descriptionLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: totalView.leadingAnchor, constant: 10),
            stack.trailingAnchor.constraint(equalTo: totalView.trailingAnchor, constant: -10),
            stack.topAnchor.constraint(equalTo: totalView.topAnchor, constant: 10),
            stack.bottomAnchor.constraint(equalTo: totalView.bottomAnchor, constant: -10),
            
            totalView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            totalView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            totalView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            totalView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func registerLongPressGestureRecognizer() {
        let longPressGesture = UILongPressGestureRecognizer(
            target: self,
            action: #selector(moveToOtherTableView))
        longPressGesture.delaysTouchesBegan = true
        longPressGesture.delegate = self
        self.contentView.addGestureRecognizer(longPressGesture)
    }
    
    @objc func moveToOtherTableView(_ sender: UILongPressGestureRecognizer) {
        delegate?.showPopoverMenu(sender, using: cellViewModel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol ListCellDelegate: AnyObject {
    
    func showPopoverMenu(_ sender: UILongPressGestureRecognizer, using model: ListCellViewModel)
}
