//
//  TodoTableViewCell.swift
//  ProjectManager
//
//  Created by 조민호 on 2022/07/06.
//

import UIKit
import Combine

import SnapKit

final class TodoTableViewCell: UITableViewCell {
    private let todoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 5
        stackView.distribution = .equalCentering
        
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .secondaryLabel
        label.numberOfLines = 3
        return label
    }()
    
    private let deadlineLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        return label
    }()
    
    private var viewModel: TodoCellViewModelable?
    private var cancelBag = Set<AnyCancellable>()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0))
    }
    
    func bind(_ viewModel: TodoCellViewModelable) {
        self.viewModel = viewModel
        
        viewModel.todoTitle
            .sink { [weak self] title in
                self?.titleLabel.text = title
            }
            .store(in: &cancelBag)
        
        viewModel.todoContent
            .sink { [weak self] content in
                self?.contentLabel.text = content
            }
            .store(in: &cancelBag)
        
        viewModel.todoDeadline
            .sink { [weak self] deadline in
                self?.deadlineLabel.text = deadline
            }
            .store(in: &cancelBag)
        
        viewModel.expired
            .sink { [weak self] _ in
                self?.deadlineLabel.textColor = .systemRed
            }
            .store(in: &cancelBag)
        
        viewModel.notExpired
            .sink { [weak self] _ in
                self?.deadlineLabel.textColor = .label
            }
            .store(in: &cancelBag)
        
        viewModel.cellDidBind()
    }
    
    private func setup() {
        addSubviews()
        setupConstraint()
        setupView()
    }
    
    private func addSubviews() {
        contentView.addSubview(todoStackView)
        todoStackView.addArrangeSubviews(titleLabel, contentLabel, deadlineLabel)
    }
    
    private func setupConstraint() {
        todoStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setupView() {
        backgroundColor = .systemGray6
        contentView.backgroundColor = .systemBackground
    }
}
