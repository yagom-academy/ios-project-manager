//
//  HeaderView.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/09.
//

import UIKit

struct Header {
    let category: Category
    let count: Int
}

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
    
    // MARK: - Initializers
    init(with model: Header) {
        super.init(frame: .zero)
        setupInitialHeaderView()
        setupData(with: model)
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
    
    private func setupData(with model: Header) {
        categoryLabel.text = model.category.rawValue
        updateCount(number: model.count)
    }
    
    func updateCount(number: Int) {
        if number == 0 {
            countLabel.text = ""
            return
        }
        countLabel.text = " \(number) "
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
