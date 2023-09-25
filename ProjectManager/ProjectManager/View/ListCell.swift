//
//  ListCell.swift
//  ProjectManager
//
//  Created by Moon on 2023/09/25.
//

import UIKit

final class ListCell: UITableViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .systemGray3
        label.numberOfLines = 3
        
        return label
    }()
    
    private let deadlineLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        
        return label
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        
        return stackView
    }()
    
    // ListCell이 재사용 될 때마다 setUpViewModel을 통해 값이 들어오면 바인딩 함
    private var listCellViewModel: ListCellViewModel? {
        didSet {
            setUpBindings()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame
            .inset(by: UIEdgeInsets(
                top: 8,
                left: .zero,
                bottom: .zero,
                right: .zero)
            )
    }
    
    // ListCell이 재사용 될 때 ListCellViewModel을 받아옴
    func setUpViewModel(_ viewModel: ListCellViewModel) {
        self.listCellViewModel = viewModel
    }
    
    // viewModel을 받을 때마다 바인딩할 것
    private func setUpBindings() {
        listCellViewModel?.bindTitle { [weak self] viewModel in
            self?.titleLabel.text = viewModel.title
        }
        
        listCellViewModel?.bindDescription { [weak self] viewModel in
            self?.descriptionLabel.text = viewModel.description
        }
        
        listCellViewModel?.bindDeadline { [weak self] viewModel in
            self?.deadlineLabel.text = viewModel.deadline
        }
    }
}

// MARK: - Configure UI
extension ListCell {
    private func configureUI() {
        addSubviews()
        setUpContentStackViewConstraints()
        setUpBackgroundColors()
    }
    
    private func addSubviews() {
        [titleLabel, descriptionLabel, deadlineLabel].forEach {
            contentStackView.addArrangedSubview($0)
        }
        
        contentView.addSubview(contentStackView)
    }
    
    private func setUpContentStackViewConstraints() {
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor
                .constraint(equalTo: contentView.leadingAnchor, constant: 8),
            contentStackView.trailingAnchor
                .constraint(equalTo: contentView.trailingAnchor, constant: -8),
            contentStackView.topAnchor
                .constraint(equalTo: contentView.topAnchor, constant: 8),
            contentStackView.bottomAnchor
                .constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    private func setUpBackgroundColors() {
        backgroundColor = .systemGray6
        contentView.backgroundColor = .systemBackground
    }
}
