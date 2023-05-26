//
//  ProjectManager - ProjectCell.swift
//  Created by Rhode.
//  Copyright © yagom. All rights reserved.
//

import UIKit

final class ProjectCell: UICollectionViewCell {
    let identifier = "ProjectCell"
    var deleteRow: (() -> ())?
    
    private let cellScrollView: UIScrollView = {
        let scrollView = UIScrollView()
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
        stackView.alignment = .leading
        stackView.spacing = 5
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 3
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        
        return label
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete", for: .normal)
        button.backgroundColor = .systemRed
        button.addTarget(self, action: #selector(deleteCell), for: .touchUpInside)
        
        return button
    }()
    
    private let deleteView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemRed
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContentStackView()
        configureConstraint()
        cellScrollView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContent(title: String, body: String, date: String) {
        titleLabel.text = title
        bodyLabel.text = body
        dateLabel.text = date
        
        scrollToZero()
        cellScrollView.contentInset.left = 70
    }
    
    private func scrollToZero() {
        cellScrollView.setContentOffset(CGPoint(x: -70, y: 0), animated: false)
    }
    
    @objc
    private func deleteCell() {
        deleteRow?()
    }
    
    func changeDateColor(isOverdue: Bool) {
        if isOverdue {
            dateLabel.textColor = .systemRed
        } else {
            dateLabel.textColor = .black
        }
    }
    
    private func configureContentStackView() {
        addSubview(cellScrollView)
        cellScrollView.addSubview(cellStackView)
        cellStackView.addArrangedSubview(contentStackView)
        cellStackView.addArrangedSubview(deleteButton)
        cellStackView.addArrangedSubview(deleteView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(bodyLabel)
        contentStackView.addArrangedSubview(dateLabel)
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            cellScrollView.topAnchor.constraint(equalTo: topAnchor),
            cellScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            cellScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cellStackView.topAnchor.constraint(equalTo: cellScrollView.contentLayoutGuide.topAnchor),
            cellStackView.leadingAnchor.constraint(equalTo: cellScrollView.contentLayoutGuide.leadingAnchor, constant: -70),
            cellStackView.trailingAnchor.constraint(equalTo: cellScrollView.contentLayoutGuide.trailingAnchor),
            cellStackView.bottomAnchor.constraint(equalTo: cellScrollView.contentLayoutGuide.bottomAnchor),
            cellStackView.topAnchor.constraint(equalTo: cellScrollView.frameLayoutGuide.topAnchor),
            cellStackView.bottomAnchor.constraint(equalTo: cellScrollView.frameLayoutGuide.bottomAnchor),
            contentStackView.widthAnchor.constraint(equalTo: cellScrollView.frameLayoutGuide.widthAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: 70),
            deleteView.widthAnchor.constraint(equalTo: cellScrollView.frameLayoutGuide.widthAnchor, constant: -70)
        ])
    }
}

extension ProjectCell: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollView.isPagingEnabled = true
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        scrollView.isPagingEnabled = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x >= scrollView.frame.width - 70 {
            deleteRow?()
        }
    }
}
