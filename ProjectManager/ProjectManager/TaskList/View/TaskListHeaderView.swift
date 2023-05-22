//
//  TaskListHeaderView.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/18.
//

import UIKit
import Combine

class TaskListHeaderView: UIView {
    private let viewModel: TaskListHeaderViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    private let titleLabel = {
        let label = UILabel()
        
        label.font = .preferredFont(forTextStyle: .largeTitle)
        
        return label
    }()
    
    private lazy var countLabel = {
        let label = CountLabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title3)
        label.backgroundColor = .black
        label.textColor = .white
        label.textAlignment = .center
        label.layer.masksToBounds = true
        
        return label
    }()
    
    private let stackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 12
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 12, left: 20, bottom: 12, right: 20)
        
        return stackView
    }()
    
    init(state: State) {
        self.viewModel = TaskListHeaderViewModel(state: state)
        
        super.init(frame: .zero)
        
        self.backgroundColor = .systemGray6
        setupStackView()
        setupConstraints()
        setupTitle()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        viewModel.$count
            .sink { [weak self] count in
                self?.countLabel.text = count
            }
            .store(in: &subscriptions)
    }
    
    private func setupTitle() {
        titleLabel.text = viewModel.title
    }
    
    private func setupStackView() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(countLabel)
        
        addSubview(stackView)
    }
    
    private func setupConstraints() {
        let safe = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safe.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safe.bottomAnchor)
        ])
    }
}
