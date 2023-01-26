//
//  ListHeaderView.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/17.
//

import UIKit

final class ListHeaderView: UIView {

    typealias Text = Constant.Text
    typealias Style = Constant.Style
    typealias Color = Constant.Color
    typealias Number = Constant.Number

    private let titleView: UIStackView = {
        let stackView = UIStackView()
//        stackView.backgroundColor = .red
        stackView.axis = .horizontal
        stackView.spacing = Style.stackViewSpacing
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    private let titleLabel = UILabel()
    private let countLabel = CircleLabel(frame: .zero)
    private let bumperView: UIView =  {
        let view = UIView()
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        return view
    }()
    private let leftPaddingView = UIView()
    private let rightPaddingView = UIView()
    private let padding: CGFloat
    
    init(title: String, padding: CGFloat, frame: CGRect) {
        self.padding = padding
        super.init(frame: frame)
        
        configure()
        setTitle(text: title)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        leftPaddingView.backgroundColor = .systemGray3
        rightPaddingView.backgroundColor = .systemGray3
        configureViewHierarchy()
        configureLayoutConstraint()
    }
    
    private func setTitle(text: String) {
        titleLabel.text = text
    }
    
    func setCount(number: Int?) {
        guard let count = number else {
            return
        }
        if count > Number.maxCount {
            countLabel.text = Text.overCount
        } else {
            countLabel.text = String(count)
        }
    }

    private func configureViewHierarchy() {
        [leftPaddingView, titleLabel, countLabel, bumperView, rightPaddingView].forEach {
            titleView.addArrangedSubview($0)
        }
        addSubview(titleView)
    }

    private func configureLayoutConstraint() {
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: topAnchor),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleView.bottomAnchor.constraint(equalTo: bottomAnchor),
            leftPaddingView.widthAnchor.constraint(equalToConstant: padding),
            leftPaddingView.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, constant: 16),
            rightPaddingView.widthAnchor.constraint(equalToConstant: padding),
            rightPaddingView.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, constant: 16),
        ])
    }
}
