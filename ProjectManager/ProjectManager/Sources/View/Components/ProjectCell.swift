//
//  ProjectCell.swift
//  ProjectManager
//
//  Created by Hamo, Wonbi on 2023/01/17.
//

import UIKit

final class ProjectCell: UITableViewCell {
    static let reuseIdentifier = String(describing: ProjectCell.self)
    private var projectCellViewModel: ProjectCellViewModel?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubViews()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSubViews() {
        [titleLabel, descriptionLabel, dateLabel].forEach {
            totalStackView.addArrangedSubview($0)
        }
        
        contentView.addSubview(totalStackView)
    }
    
    private func configureLayout() {
        totalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = contentView.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            totalStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
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
    func setupViewModel(_ viewModel: ProjectCellViewModel) {
        projectCellViewModel = viewModel
        bindProjectCellViewModel()
    }
    
    private func bindProjectCellViewModel() {
        projectCellViewModel?.titleHandler = { [weak self] text in
            self?.titleLabel.text = text
        }
        
        projectCellViewModel?.deadlineHandler = { [weak self] text in
            self?.dateLabel.text = text
        }
        
        projectCellViewModel?.descriptionHandler = { [weak self] text in
            self?.descriptionLabel.text = text
        }
    }
}
