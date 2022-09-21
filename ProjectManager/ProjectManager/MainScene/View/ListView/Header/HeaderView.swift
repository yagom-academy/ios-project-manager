//
//  HeaderView.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/09.
//

import UIKit

final class HeaderView: UIView {
    // MARK: - UIComponents
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.textColor = .white
        label.layer.backgroundColor = UIColor.black.cgColor
        return label
    }()

    private var viewModel: HeaderViewModel
    private var category: String
    
    // MARK: - Initializers
    init(category: String) {
        self.category = category
        self.viewModel = HeaderViewModel(category: category)
        super.init(frame: .zero)
        setupInitialHeaderView()
        setupData()
        bindDidChangedCount()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setupInitialHeaderView() {
        backgroundColor = .systemGray6
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
    
    func setupData() {
        viewModel.configure(self)
    }
    
    func bindDidChangedCount() {
        viewModel.didChangedCount = {
            self.setupData()
        }
    }
    
    override func draw(_ rect: CGRect) {
        let separator = UIBezierPath()
        separator.move(to: CGPoint(x: 0, y: 60))
        separator.addLine(to: CGPoint(x: bounds.width, y: 60))
        separator.lineWidth = 1
        UIColor.lightGray.setStroke()
        separator.stroke()
        separator.close()
    }
}
