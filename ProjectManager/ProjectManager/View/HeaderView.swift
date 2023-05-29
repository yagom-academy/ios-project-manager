//
//  HeaderView.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/23.
//

import UIKit

final class HeaderView: UIView {
    private let titleLabel = UILabel()
    private let countLabel = CircleLabel()
    private let seperatorView = UIView()
   
    init(text: String, frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleLabel)
        self.addSubview(countLabel)
        self.addSubview(seperatorView)
        
        titleLabel.text = text
        titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        setUpHeaderView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpHeaderView() {
        let titleLabelLeading: CGFloat = 10
        let countLabelLeading: CGFloat = 20
        
        seperatorView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            seperatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            seperatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            seperatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            seperatorView.heightAnchor.constraint(equalToConstant: 1),
        
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: titleLabelLeading),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            countLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: countLabelLeading),
            countLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            countLabel.widthAnchor.constraint(equalTo: countLabel.heightAnchor)
        ])

        titleLabel.sizeToFit()
        seperatorView.backgroundColor = .placeholderText
    }

    func changeCount(_ count: String) {
        countLabel.changeText(count: count)
    }
}
