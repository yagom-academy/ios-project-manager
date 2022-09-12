//
//  CardListHeaderView.swift
//  ProjectManager
//
//  Created by Derrick kim on 9/8/22.
//

import UIKit

final class CardHeaderView: UIView {
    private enum Const {
        static let stackViewSpacing = 16.0
        static let baseConstraint = 16.0
        static let layerCornerRadius = 30.0
    }
    
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
        $0.layer.cornerRadius = Const.layerCornerRadius * 0.5
        $0.layer.masksToBounds = true
        $0.text = "10"
    }
    
    private lazy var rootStackView = UIStackView(
        arrangedSubviews: [subjectTitleLabel, countLabel]).then {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.axis = .horizontal
            $0.alignment = .center
            $0.spacing = Const.stackViewSpacing
        }
    
    init(cardType: CardType) {
        super.init(frame: .zero)
        setupDefault()
        
        self.subjectTitleLabel.text = cardType.rawValue
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.addBottomBorder()
    }
    
    private func setupDefault() {
        self.addSubview(rootStackView)

        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: self.topAnchor,
                                               constant: Const.baseConstraint),
            rootStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                                  constant: -Const.baseConstraint),
            rootStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                   constant: Const.baseConstraint),
            
            countLabel.widthAnchor.constraint(equalTo: countLabel.heightAnchor),
            countLabel.widthAnchor.constraint(equalToConstant: Const.baseConstraint * 2)
        ])
    }
}
