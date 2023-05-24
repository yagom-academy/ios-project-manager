//
//  TodoCell.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/19.
//

import UIKit

final class TaskCell: UICollectionViewListCell {
    static let identifier = "TaskCell"
    
    let titleLabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    let bodyLabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .systemGray4
        label.numberOfLines = 3
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    let dateLabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    let visibleStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    let scrollContentView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let hiddenContainerView = {
        let view = UIView()
        view.backgroundColor = .systemRed
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContentLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func configureContentLayout() {
        visibleStackView.addArrangedSubview(titleLabel)
        visibleStackView.addArrangedSubview(bodyLabel)
        visibleStackView.addArrangedSubview(dateLabel)
        
        scrollContentView.addArrangedSubview(visibleStackView)
        scrollContentView.addArrangedSubview(hiddenContainerView)
        
        scrollView.addSubview(scrollContentView)
        
        contentView.addSubview(visibleStackView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            scrollContentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollContentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollContentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    func provide(_ item: TaskCellViewModel) {
        titleLabel.text = item.title
        bodyLabel.text = item.body
        dateLabel.text = item.date
    }
}
