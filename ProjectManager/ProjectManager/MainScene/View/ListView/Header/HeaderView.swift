//
//  HeaderView.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/09.
//

import UIKit

final class HeaderView: UIView {
    
    // MARK: - UIComponents
    private let categoryLabel = DefaultLabelBuilder()
        .useAutoLayout()
        .setPreferredFont(.largeTitle)
        .label
    
    private let countLabel = DefaultLabelBuilder()
        .useAutoLayout()
        .setPreferredFont(.title3)
        .setLayerMaskToBounds(true)
        .setLayerCornerRadius(10)
        .setTextColor(with: .white)
        .setLayerBackgroundColor(.black)
        .label
    
    private var viewModel: HeaderViewModel
    
    // MARK: - Initializers
    init(viewModel: HeaderViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupInitialHeaderView()
        setupCategoryLabel()
        updateHeaderCount()
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
    
    private func setupCategoryLabel() {
        categoryLabel.text = viewModel.category
    }
    
    private func updateHeaderCount() {
        countLabel.text = " \(viewModel.count) "
    }
    
    private func bindDidChangedCount() {
        viewModel.didChangedCount = { [weak self] in
            self?.updateHeaderCount()
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
