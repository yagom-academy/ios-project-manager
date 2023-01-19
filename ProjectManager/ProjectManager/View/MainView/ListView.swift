//
//  ListView.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/13.
//

import UIKit

final class ListView: UIView {
    
    private let headView = UIView(backgroundColor: .systemGroupedBackground)
    private let titleLabel = UILabel(font: .title1, textAlignment: .center)
    private let countLabel = CircleLabel(text: Default.count)
    private let separatorLineView = UIView(backgroundColor: .systemGray3)
    private let headStackView = UIStackView(axis: .vertical, alignment: .leading)
    private let headAndListStackView = UIStackView(axis: .vertical,
                                                   spacing: Default.stackSpacing,
                                                   backgroundColor: .systemGroupedBackground)
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(ListCell.self, forCellReuseIdentifier: ListCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    var projectTableView: UITableView {
        return tableView
    }
    
    init() {
        super.init(frame: .zero)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupListTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func setupCountText(_ count: String) {
        countLabel.text = count
    }
    
    func setupProjectList(delegator: UITableViewDelegate, color: UIColor) {
        tableView.delegate = delegator
        tableView.backgroundColor = color
    }
}

// MARK: - Layout
extension ListView {
    
    private func configureHierarchy() {
        [titleLabel, countLabel].forEach { headView.addSubview($0) }
        [headView, separatorLineView].forEach { headStackView.addArrangedSubview($0) }
        [headStackView, tableView].forEach { headAndListStackView.addArrangedSubview($0) }
        addSubview(headAndListStackView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            headView.widthAnchor.constraint(equalTo: widthAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: headView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: headView.centerYAnchor),
            titleLabel.heightAnchor.constraint(equalTo: headView.heightAnchor),
            
            countLabel.trailingAnchor.constraint(equalTo: headView.trailingAnchor,
                                                 constant: Default.countLabelTrailingSpacing),
            countLabel.centerYAnchor.constraint(equalTo: headView.centerYAnchor),
            countLabel.widthAnchor.constraint(greaterThanOrEqualTo: countLabel.heightAnchor),
            
            headStackView.heightAnchor.constraint(equalTo: heightAnchor,
                                                  multiplier: Default.headStackHeightRatio),
            
            separatorLineView.heightAnchor.constraint(equalToConstant: Default.separatorLineHeight),
            separatorLineView.widthAnchor.constraint(equalTo: headStackView.widthAnchor),
            
            headAndListStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headAndListStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headAndListStackView.topAnchor.constraint(equalTo: topAnchor),
            headAndListStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - NameSpace
extension ListView {
    
    private enum Default {
        
        static let count = "0"
        static let stackSpacing: CGFloat = 5
        static let countLabelTrailingSpacing: CGFloat = -40
        static let headStackHeightRatio: CGFloat = 0.1
        static let separatorLineHeight: CGFloat = 1
    }
}
