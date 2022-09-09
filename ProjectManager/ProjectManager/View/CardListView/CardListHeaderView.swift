//
//  CardListHeaderView.swift
//  ProjectManager
//
//  Created by Derrick kim on 9/8/22.
//

import UIKit

final class CardListHeaderView: UIView {
    private let subjectTitleLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.preferredFont(forTextStyle: .largeTitle)
    }
    
    let countLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .preferredFont(forTextStyle: .title3)
        $0.backgroundColor = .black
        $0.textColor = .systemBackground
        $0.textAlignment = .center
        $0.layer.cornerRadius = 30 * 0.5
        $0.layer.masksToBounds = true
        $0.text = "10"
    }
    
    private lazy var rootStackView = UIStackView(
        arrangedSubviews: [subjectTitleLabel, countLabel]).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 16.0
        
    }
    
    init(cardType: CardType) {
        super.init(frame: .zero)
        self.addSubview(rootStackView)
        configureLayout()
        self.subjectTitleLabel.text = cardType.rawValue
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            rootStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            rootStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            countLabel.widthAnchor.constraint(equalTo: countLabel.heightAnchor),
            countLabel.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}
