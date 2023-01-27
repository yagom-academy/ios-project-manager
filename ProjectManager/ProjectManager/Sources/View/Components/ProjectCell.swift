//
//  ProjectCell.swift
//  ProjectManager
//
//  Created by Hamo, Wonbi on 2023/01/17.
//

import UIKit

enum DateColor {
    case red
    case black
    
    var value: UIColor {
        switch self {
        case .red:
            return .systemRed
        case .black:
            return .black
        }
    }
}

final class ProjectCell: UITableViewCell {
    static let reuseIdentifier = String(describing: ProjectCell.self)
    private var viewModel: ProjectCellViewModel?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .systemGray
        label.numberOfLines = 3
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        
        return label
    }()
    
    private let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.backgroundColor = .white
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layer.cornerRadius = 8
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubviews()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSubviews() {
        [titleLabel, descriptionLabel, dateLabel].forEach {
            totalStackView.addArrangedSubview($0)
        }
        
        contentView.backgroundColor = .systemGray6
        contentView.addSubview(totalStackView)
    }
    
    private func configureLayout() {
        totalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = contentView.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            totalStackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 8),
            totalStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            totalStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            totalStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    func configureLongPressGesture(target: Any?, action: Selector?) {
        let gesture = UILongPressGestureRecognizer(target: target, action: action)
        addGestureRecognizer(gesture)
    }
}

// MARK: Configure ProjectListCellViewModel
extension ProjectCell {
    func setViewModel(_ viewModel: ProjectCellViewModel) {
        self.viewModel = viewModel
        bindProjectCellViewModel()
    }
    
    private func bindProjectCellViewModel() {
        viewModel?.titleHandler = { [weak self] text in
            self?.titleLabel.text = text
        }
        
        viewModel?.deadlineHandler = { [weak self] deadline in
            self?.dateLabel.text = deadline?.date
            self?.dateLabel.textColor = deadline?.color.value
        }
        
        viewModel?.descriptionHandler = { [weak self] text in
            self?.descriptionLabel.text = text
        }
    }
}
