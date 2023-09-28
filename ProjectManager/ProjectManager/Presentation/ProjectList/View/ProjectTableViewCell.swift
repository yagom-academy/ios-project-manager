//
//  ProjectTableViewCell.swift
//  ProjectManager
//
//  Created by Erick on 2023/09/20.
//

import UIKit

final class ProjectTableViewCell: UITableViewCell {

    // MARK: - Static Property
    static let identifier = String(describing: ProjectTableViewCell.self)
    
    // MARK: - Private Property
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 8
        
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .systemGray
        label.numberOfLines = 0
        
        return label
    }()
    
    private let deadlineLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        
        return label
    }()
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - layout SubViews
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(
            by: UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
        )
    }
}

// MARK: - Interface
extension ProjectTableViewCell {
    func setupViewModel(_ viewModel: ProjectTableViewCellViewModel) {
        setupBindings(viewModel)
    }
    
    private func setupBindings(_ viewModel: ProjectTableViewCellViewModel) {
        titleLabel.text = viewModel.title
        bodyLabel.text = viewModel.body
        deadlineLabel.text = viewModel.deadline
        deadlineLabel.textColor = viewModel.deadlineColor
    }
}

// MARK: - Configure UI
extension ProjectTableViewCell {
    private func configureUI() {
        configureView()
        configureStackView()
        configureLayout()
    }
    
    private func configureView() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(stackView)
        contentView.backgroundColor = .systemBackground
    }
    
    private func configureStackView() {
        [titleLabel, bodyLabel, deadlineLabel].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    private func configureLayout() {
        let safe = contentView.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -8),
            stackView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -8)
        ])
    }
}
