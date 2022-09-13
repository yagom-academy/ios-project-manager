//
//  TableHeaderView.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/08.
//

import UIKit

// MARK: - NameSpace

private enum Design {
    static let mainStackViewSpacing: CGFloat = 8
    static let mainStackViewLeadingAnchor: CGFloat = 8
    static let countLabelSize: CGFloat = 25
    static let countLabelBorderWidth: CGFloat = 1
}

final class ProjectTableHeaderView: UIView {
    // MARK: - Properties
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis  = .horizontal
        stackView.spacing = Design.mainStackViewSpacing
        
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title1)
        
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: Design.countLabelSize).isActive = true
        label.widthAnchor.constraint(equalToConstant: Design.countLabelSize).isActive = true
        label.font = .preferredFont(forTextStyle: .title3)
        label.layer.backgroundColor = UIColor.black.cgColor
        label.layer.borderWidth = Design.countLabelBorderWidth
        label.layer.cornerRadius = Design.countLabelSize / 2
        label.textAlignment = .center
        label.textColor = .white

        return label
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Methods
    
    func setItems(title: String?, count: String?) {
        titleLabel.text = title
        countLabel.text = count
    }
    
    private func commonInit() {
        configureView()
        configureMainStackViewLayouts()
    }
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainStackView)
        [titleLabel, countLabel].forEach { mainStackView.addArrangedSubview($0) }
    }
    
    private func configureMainStackViewLayouts() {
        mainStackView.leadingAnchor
            .constraint(equalTo: self.leadingAnchor,
                        constant: Design.mainStackViewLeadingAnchor).isActive = true
    }
}
