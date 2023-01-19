//
//  ListCell.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/13.
//

import UIKit

protocol ListCellDelegate: AnyObject {
    
    func showPopoverMenu(_ sender: UILongPressGestureRecognizer, using model: ListCellViewModel)
}

final class ListCell: UITableViewCell {
    
    static let identifier = "projectCell"
    
    var cellViewModel: ListCellViewModel? {
        didSet {
            if cellViewModel != nil {
                bidingViewModel()
            }
        }
    }
    
    weak var delegate: ListCellDelegate?
    private var titleLabel = UILabel(font: .title3)
    private var descriptionLabel = UILabel(font: .body, textColor: .systemGray2, numberOfLines: 3)
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
    
    private func bidingViewModel() {
        cellViewModel?.updateTitleDate = { [weak self] data in
            self?.titleLabel.text = data
        }
        
        cellViewModel?.updateDescriptionDate = { [weak self] data in
            self?.descriptionLabel.text = data
        }
        
        cellViewModel?.updateDateDate = { [weak self] data, isMissDeadLine, state in
            self?.dateLabel.text = data
            
            guard isMissDeadLine && state != .done else { return }
            self?.dateLabel.textColor = .red
        }
    }
    
    private func registerLongPressGestureRecognizer() {
        let longPressGesture = UILongPressGestureRecognizer( target: self,
                                                             action: #selector(moveToOtherList))
        longPressGesture.delaysTouchesBegan = true
        
        self.contentView.addGestureRecognizer(longPressGesture)
    }
    
    @objc private func moveToOtherList(_ sender: UILongPressGestureRecognizer) {
        guard let cellViewModel = cellViewModel else { return }
        delegate?.showPopoverMenu(sender, using: cellViewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout
extension ListCell {
    
    private func configureHierarchy() {
        [titleLabel, descriptionLabel, dateLabel].forEach { stackView.addArrangedSubview($0) }
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
