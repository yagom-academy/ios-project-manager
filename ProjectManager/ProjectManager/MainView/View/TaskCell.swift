//
//  TodoCell.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/19.
//

import UIKit

protocol SwipeableCollectionViewCellDelegate: AnyObject {
    func tapHiddenContainerView(inCell cell: UICollectionViewCell)
    func tapVisibleContainerView(inCell cell: UICollectionViewCell)
}

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
        scrollView.bounces = false
        
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
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let deleteLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Delete"
        
        return label
    }()
    
    weak var delegate: SwipeableCollectionViewCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContentLayout()
        setupGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func provide(_ item: TaskCellViewModel) {
        titleLabel.text = item.title
        bodyLabel.text = item.body
        dateLabel.text = item.date
    }
    
    private func configureContentLayout() {
        visibleStackView.addArrangedSubview(titleLabel)
        visibleStackView.addArrangedSubview(bodyLabel)
        visibleStackView.addArrangedSubview(dateLabel)
        
        hiddenContainerView.addSubview(deleteLabel)
        
        scrollContentView.addArrangedSubview(visibleStackView)
        scrollContentView.addArrangedSubview(hiddenContainerView)
        
        scrollView.addSubview(scrollContentView)
        
        addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            scrollContentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollContentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollContentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollContentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            scrollContentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1.3),

            hiddenContainerView.widthAnchor.constraint(equalTo: visibleStackView.widthAnchor, multiplier: 0.15),
            
            deleteLabel.centerXAnchor.constraint(equalTo: hiddenContainerView.centerXAnchor),
            deleteLabel.centerYAnchor.constraint(equalTo: hiddenContainerView.centerYAnchor),
        ])
    }
    
    private func setupGestureRecognizer() {
        let hiddenContainerTapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(tapHiddenContainerView)
        )
        hiddenContainerView.addGestureRecognizer(hiddenContainerTapGestureRecognizer)
        
        let visibleContainerTapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(tapVisibleContainerView)
        )
        visibleStackView.addGestureRecognizer(visibleContainerTapGestureRecognizer)
    }
    
    @objc
    private func tapHiddenContainerView() {
        delegate?.tapHiddenContainerView(inCell: self)
    }
    
    @objc
    private func tapVisibleContainerView() {
        delegate?.tapVisibleContainerView(inCell: self)
    }
}
