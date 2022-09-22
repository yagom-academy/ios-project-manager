//
//  HistoryCell.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/21.
//

import UIKit

final class HistoryCell: UIView {
    
    // MARK: - UIComponents
    private let cellStackView = DefaultStackViewBuilder()
        .useAutoLayout()
        .setAxis(.vertical)
        .setAlignment(.leading)
        .setDistribution(.fillEqually)
        .useLayoutMargin()
        .setLayoutMargin(top: 10,
                         left: 10,
                         bottom: 10,
                         right: 10)
        .stackView
    
    private let titleLabel = DefaultLabelBuilder()
        .useAutoLayout()
        .setPreferredFont(.title3)
        .label
    
    private let dateLabel = DefaultLabelBuilder()
        .useAutoLayout()
        .setPreferredFont(.body)
        .setTextColor(with: .systemGray3)
        .label
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 400, height: 80)
    }
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupInitialView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setupInitialView() {
        addSubview(cellStackView)
        cellStackView.addArrangedSubview(titleLabel)
        cellStackView.addArrangedSubview(dateLabel)
    }
    
    func setupData(title: String, date: Date) {
        titleLabel.text = title
        dateLabel.text = date.timeIntervalSince1970.translateToTime()
    }
    
    override func draw(_ rect: CGRect) {
        let separator = UIBezierPath()
        separator.move(to: CGPoint(x: 0, y: bounds.maxY))
        separator.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        separator.lineWidth = 1
        UIColor.lightGray.setStroke()
        separator.stroke()
        separator.close()
    }
}
