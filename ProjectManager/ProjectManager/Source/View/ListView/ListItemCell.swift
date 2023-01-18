//
//  ListItemCell.swift
//  ProjectManager
//  Created by inho on 2023/01/12.
//

import UIKit

class ListItemCell: UITableViewCell {
    static let identifier = String(describing: ListItemCell.self)
    private let cellStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 3
        
        return stackView
    }()
    private let listTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: UIFont.labelFontSize)
        
        return label
    }()
    private let listBodyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIFont.labelFontSize)
        label.textColor = .systemGray
        label.numberOfLines = 3
        
        return label
    }()
    private let dueDateLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: UIFont.smallSystemFontSize)
        
        return label
    }()
    private let spacingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        
        return view
    }()
    
    var viewModel: ListItemCellViewModel?
    var delegate: MenuPresentable?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureLayout()
        addLongPressGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        [listTitleLabel, listBodyLabel, dueDateLabel].forEach {
            cellStackView.addArrangedSubview($0)
        }
        contentView.addSubview(spacingView)
        contentView.addSubview(cellStackView)
        
        cellStackView.isLayoutMarginsRelativeArrangement = true
        cellStackView.layoutMargins = .init(top: 5, left: 15, bottom: 5, right: 15)
        
        NSLayoutConstraint.activate([
            spacingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            spacingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            spacingView.topAnchor.constraint(equalTo: contentView.topAnchor),
            spacingView.heightAnchor.constraint(equalToConstant: 10),
            
            cellStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellStackView.topAnchor.constraint(equalTo: spacingView.bottomAnchor),
            cellStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func addLongPressGesture() {
        let longPressGesture = UILongPressGestureRecognizer(
            target: self,
            action: #selector(notifyDelegate)
        )
        
        longPressGesture.minimumPressDuration = 1
        contentView.addGestureRecognizer(longPressGesture)
    }
    
    @objc func notifyDelegate(_ gesture: UILongPressGestureRecognizer) {
        guard let viewModel = viewModel else { return }

        delegate?.didLongPressGesture(gesture, viewModel)
    }
    
    func bind(_ viewModel: ListItemCellViewModel) {
        self.viewModel = viewModel
        
        viewModel.bind { [weak self] item in
            self?.listTitleLabel.text = item.title
            self?.listBodyLabel.text = item.body
            self?.dueDateLabel.text = item.dueDate
            self?.dueDateLabel.textColor = item.isOverDue ? .systemRed : .black
        }
    }
    
    func update(_ listItem: ListItem) {
        viewModel?.updateItem(using: listItem)
    }
}
