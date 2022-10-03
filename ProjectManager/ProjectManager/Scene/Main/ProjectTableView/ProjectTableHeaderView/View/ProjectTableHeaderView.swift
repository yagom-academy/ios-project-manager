//
//  ProjectTableHeaderView.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/13.
//

import UIKit

final class ProjectTableHeaderView: UIView {
   
    let projectTableHeaderViewModel: ProjectTableHeaderViewModel
    private let projectType: ProjectType
    
    // MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title1)
        
        return label
    }()
    
    private let indexLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .title3)
        label.backgroundColor = .black
        
        return label
    }()
    
    // MARK: - Initializers
    
    init(with project: ProjectType, to viewModel: ProjectTableHeaderViewModel) {
        self.projectTableHeaderViewModel = viewModel
        self.projectType = project
        super.init(frame: .zero)
        titleLabel.text = projectType.titleLabel
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        self.projectTableHeaderViewModel = ProjectTableHeaderViewModel(dataManager: FakeToDoItemManager())
        self.projectType = .todo
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupViewComponents()
        setupSubviews()
        setupConstraints()
        setupIndexLabel()
    }
    
    // MARK: - Functions
    
    func setupLabel() {
        indexLabel.text = projectTableHeaderViewModel.count(of: projectType)
    }
    
    private func setupViewComponents() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemGray5
    }
    
    private func setupSubviews() {
        [titleLabel, indexLabel]
            .forEach { addSubview($0) }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            indexLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            indexLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            indexLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            indexLabel.widthAnchor.constraint(equalTo: indexLabel.heightAnchor)
        ])
    }
    
    private func setupIndexLabel() {
        indexLabel.layoutIfNeeded()
        indexLabel.drawCircle()
    }
    
    // MARK: - Name Space
    
    private enum Design {
        static let verticalStackViewSpacing: CGFloat = 2
        static let todotitleLabelText = "TODO"
        static let doingtitleLabelText = "DOING"
        static let donetitleLabelText = "DONE"
    }
}
