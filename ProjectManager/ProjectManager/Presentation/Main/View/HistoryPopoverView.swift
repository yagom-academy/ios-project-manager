//
//  HistoryListCell.swift
//  ProjectManager
//
//  Created by Lee Seung-Jae on 2022/03/22.
//

import UIKit
import RxSwift
import RxCocoa

private enum Design {
    static let stackViewSpacing = 4.0
    static let statusLabelTitle = "변경내역이 없습니다."
    static let statusLabelFont = UIFont.preferredFont(forTextStyle: .title3)
    static let statuslabelColor = UIColor.systemGray
    static let viewBackgroundColor = UIColor.systemGray6
    static let stackViewLeadingAnchorConstant = 5.0
    static let stackViewTrailingAnchorConstant = -5.0
    static let stackViewTopAnchorConstant = 8.0
    static let stackViewBottomAnchorConstant = -8.0
}

class HistoryPopoverView: UIView {

    let tableView = UITableView()
    let statusLabel: UILabel = {
        let label = UILabel()
        label.font = Design.statusLabelFont
        label.textColor = Design.statuslabelColor
        label.text = Design.statusLabelTitle
        return label
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = Design.stackViewSpacing
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
}

private extension HistoryPopoverView {

    func commonInit() {
        self.configure()
    }

    func configure() {
        self.backgroundColor = Design.viewBackgroundColor
        self.configureHierarchy()
        self.configureConstraint()
        self.configureTableView()
    }

    func configureHierarchy() {
        self.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.tableView)
        self.tableView.addSubview(statusLabel)
    }

    func configureConstraint() {
        let safeAreaLayoutGuide = self.safeAreaLayoutGuide

        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.statusLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: Design.stackViewLeadingAnchorConstant
            ),
            self.stackView.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: Design.stackViewTrailingAnchorConstant
            ),
            self.stackView.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor,
                constant: Design.stackViewTopAnchorConstant
            ),
            self.stackView.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor,
                constant: Design.stackViewBottomAnchorConstant
            ),
            self.statusLabel.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor),
            self.statusLabel.centerYAnchor.constraint(equalTo: self.tableView.centerYAnchor)
        ])
    }

    func configureTableView() {
        self.tableView.register(cellWithClass: HistoryListCell.self)
    }
}
