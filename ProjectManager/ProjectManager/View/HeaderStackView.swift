//
//  HeaderStackView.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/18.
//

import UIKit

final class HeaderStackView: UIStackView {
    private let title = UILabel()
    private let countLabel = CircleLabel()
    private let spacingView = UIView()

    init(text: String? = nil) {
        super.init(frame: .zero)
        title.text = text
        title.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        
        self.backgroundColor = .systemGray3
        self.axis = .horizontal
        self.spacing = 10
        self.addArrangedSubview(title)
        self.addArrangedSubview(countLabel)
        self.addArrangedSubview(spacingView)
        
        spacingView.setContentHuggingPriority(.init(1), for: .horizontal)
        title.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countLabel.widthAnchor.constraint(equalTo: self.heightAnchor),
            countLabel.heightAnchor.constraint(equalTo: countLabel.widthAnchor)
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeCount(_ count: String) {
        countLabel.changeText(count: count)
    }
}
