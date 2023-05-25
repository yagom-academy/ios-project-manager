//
//  TaskListCell.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/17.
//

import UIKit
import Combine

final class TaskListCell: UICollectionViewCell {
    private let viewModel = TaskListCellViewModel()
    private var subscriptions = Set<AnyCancellable>()
    
    private let titleLabel = {
        let label = UILabel()
        
        label.font = .preferredFont(forTextStyle: .title2)
        label.numberOfLines = 1
        
        return label
    }()
    
    private let bodyLabel = {
        let label = UILabel()
        
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .systemGray
        label.numberOfLines = 3
        
        return label
    }()
    
    private let deadlineLabel = {
        let label = UILabel()
        
        label.font = .preferredFont(forTextStyle: .body)
        
        return label
    }()
    
    private let stackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setupConstraints()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0.5)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 1
    }
    
    private func addSubviews() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(bodyLabel)
        stackView.addArrangedSubview(deadlineLabel)
        contentView.addSubview(stackView)
    }
    
    private func setupConstraints() {
        let safe = contentView.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safe.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safe.bottomAnchor)
        ])
    }
    
    func bind(_ task: MyTask) {
        viewModel.updateContents(by: task)
        
        viewModel.$title
            .sink { [weak self] in
                self?.titleLabel.text = $0
            }
            .store(in: &subscriptions)
        
        viewModel.$body
            .sink { [weak self] in
                self?.bodyLabel.text = $0
            }
            .store(in: &subscriptions)
        
        viewModel.$deadlineText
            .sink { [weak self] in
                self?.deadlineLabel.text = $0
            }
            .store(in: &subscriptions)
        
        viewModel.$deadlineColor
            .sink { [weak self] in
                self?.deadlineLabel.textColor = $0
            }
            .store(in: &subscriptions)
    }
}
