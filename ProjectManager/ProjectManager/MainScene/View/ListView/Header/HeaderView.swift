//
//  HeaderView.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/09.
//

import UIKit

final class HeaderView: UIView {
    // MARK: - UIComponents
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.textColor = .white
        label.layer.backgroundColor = UIColor.black.cgColor
        return label
    }()
    
    private var viewModel: TodoListViewModel
    
    // MARK: - Initializers
    init(category: String, viewModel: TodoListViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupInitialHeaderView(with: category)
        setupCountLabel(with: category)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setupInitialHeaderView(with category: String) {
        backgroundColor = .systemGray6
        categoryLabel.text = category
        addSubview(categoryLabel)
        addSubview(countLabel)
        NSLayoutConstraint.activate([
            categoryLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 20
            ),
            categoryLabel.centerYAnchor.constraint(
                equalTo: centerYAnchor
            ),
            countLabel.centerYAnchor.constraint(
                equalTo: centerYAnchor
            ),
            countLabel.leadingAnchor.constraint(
                equalTo: categoryLabel.trailingAnchor,
                constant: 10
            )
        ])
    }
    
    func setupCountLabel(with category: String) {
        switch category {
        case Category.todo:
            countLabel.text = " \(viewModel.todoCount) "
        case Category.doing:
            countLabel.text = " \(viewModel.doingCount) "
        case Category.done:
            countLabel.text = " \(viewModel.doneCount) "
        default:
            return
        }
    }
    
    override func draw(_ rect: CGRect) {
        let separator = UIBezierPath()
        separator.move(to: CGPoint(x: 0, y: 60))
        separator.addLine(to: CGPoint(x: 360, y: 60))
        separator.lineWidth = 1
        UIColor.lightGray.setStroke()
        separator.stroke()
        separator.close()
    }
}
