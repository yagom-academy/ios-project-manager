//
//  ProjectManager - ProjectCell.swift
//  Created by Rhode.
//  Copyright © yagom. All rights reserved.
//

import UIKit

final class ProjectCell: UICollectionViewCell {
    let identifier = "ProjectCell"
    var deleteRow : (() -> ()) = {}
    
    private let cellScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private let cellStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        
        return label
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete", for: .normal)
        button.backgroundColor = .systemRed
        button.addTarget(self, action: #selector(deleteCell), for: .touchUpInside)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContentStackView()
        configureConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContent(title: String, body: String, date: String) {
        titleLabel.text = title
        bodyLabel.text = body
        dateLabel.text = date
        
        scrollToZero()
    }
    
    private func scrollToZero() {
        cellScrollView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    @objc
    func deleteCell() {
        deleteRow()
    }
    
    private func configureContentStackView() {
        self.addSubview(cellScrollView)
        cellScrollView.addSubview(cellStackView)
        cellStackView.addArrangedSubview(contentStackView)
        cellStackView.addArrangedSubview(deleteButton)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(bodyLabel)
        contentStackView.addArrangedSubview(dateLabel)
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            cellScrollView.topAnchor.constraint(equalTo: self.topAnchor),
            cellScrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            cellScrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cellScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cellStackView.topAnchor.constraint(equalTo: cellScrollView.contentLayoutGuide.topAnchor),
            cellStackView.leadingAnchor.constraint(equalTo: cellScrollView.contentLayoutGuide.leadingAnchor),
            cellStackView.trailingAnchor.constraint(equalTo: cellScrollView.contentLayoutGuide.trailingAnchor),
            cellStackView.bottomAnchor.constraint(equalTo: cellScrollView.contentLayoutGuide.bottomAnchor),
            cellStackView.topAnchor.constraint(equalTo: cellScrollView.frameLayoutGuide.topAnchor),
            cellStackView.bottomAnchor.constraint(equalTo: cellScrollView.frameLayoutGuide.bottomAnchor),
            contentStackView.widthAnchor.constraint(equalTo: cellScrollView.frameLayoutGuide.widthAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
}
