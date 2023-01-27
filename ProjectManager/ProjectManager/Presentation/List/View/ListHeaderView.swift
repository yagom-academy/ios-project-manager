//
//  ListHeaderView.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/17.
//

import UIKit

final class ListHeaderView: UIView {

    typealias Number = Constant.Number

    private let headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    private let titleLabel = UILabel()
    private let countLabel: CircleLabel = {
        let label = CircleLabel(frame: .zero)
        label.configure(circleColor: UIColor.black.cgColor,
                        textColor: .white)
        
        return label
    }()
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
        countLabel.text = (count > Number.maxCountOfList) ? Text.overCount : String(count)
    }

    private func configureViewHierarchy() {
        [leftPaddingView, titleLabel, countLabel, bumperView, rightPaddingView].forEach {
            headerStackView.addArrangedSubview($0)
        }
        addSubview(headerStackView)
    }

    private func configureLayoutConstraint() {
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: topAnchor),
            headerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            leftPaddingView.widthAnchor.constraint(equalToConstant: padding),
            leftPaddingView.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, constant: 16),
            rightPaddingView.widthAnchor.constraint(equalToConstant: padding),
            rightPaddingView.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, constant: 16),
        ])
    }
}

extension ListHeaderView {
    
    enum Text {
        
        static let overCount: String = "\(Number.maxCountOfList)+"
    }
}
