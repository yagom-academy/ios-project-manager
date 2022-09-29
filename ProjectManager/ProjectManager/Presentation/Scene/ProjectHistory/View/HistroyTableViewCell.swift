//
//  HistroyTableViewCell.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/29.
//

import UIKit

// MARK: - NameSpace

private enum Design {
    static let cellReuseIdentifier = "HistoryTableViewCell"
    static let mainStackViewTopAnchor: CGFloat = 4
    static let mainStackViewBottomAnchor: CGFloat = -4
    static let mainStackViewLeadingAnchor: CGFloat = 4
    static let mainStackViewTrailingAnchor: CGFloat = -4
}

final class HistroyTableViewCell: UITableViewCell {
    // MARK: - Properties
    
    static let reuseIdentifier = Design.cellReuseIdentifier
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalCentering
        stackView.axis  = .vertical
        
        return stackView
    }()
    
    private let historyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textColor = .systemGray
        
        return label
    }()
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Methods
    
    func setItems(history: String?,
                  date: String?) {
        historyLabel.text = history
        dateLabel.text = date
    }
    
    private func commonInit() {
        configureView()
        configureMainStackViewLayouts()
    }
    
    private func configureView() {
        contentView.addSubview(mainStackView)
        [
            historyLabel,
            dateLabel
        ].forEach {
            mainStackView.addArrangedSubview($0)
        }
    }
    
    private func configureMainStackViewLayouts() {
        NSLayoutConstraint.activate(
            [
                mainStackView.topAnchor
                    .constraint(equalTo: contentView.topAnchor,
                                constant: Design.mainStackViewTopAnchor),
                mainStackView.bottomAnchor
                    .constraint(equalTo: contentView.bottomAnchor,
                                constant: Design.mainStackViewBottomAnchor),
                mainStackView.leadingAnchor
                    .constraint(equalTo: contentView.leadingAnchor,
                                constant: Design.mainStackViewLeadingAnchor),
                mainStackView.trailingAnchor
                    .constraint(equalTo: contentView.trailingAnchor,
                                constant: Design.mainStackViewTrailingAnchor)
            ]
        )
    }
}
