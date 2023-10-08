//
//  ListCollectionViewCell.swift
//  ProjectManager
//
//  Created by Karen, Zion on 2023/10/03.
//

import UIKit

protocol ListCollectionViewCellDelegate: AnyObject {
    func didLongPressCell(taskDTO: TaskDTO, cellFrame: CGRect)
}

final class ListCollectionViewCell: UICollectionViewListCell {
    weak var delegate: ListCollectionViewCellDelegate?
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 3
        label.textColor = .lightGray
        return label
    }()
    
    private let deadlineLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 10)
        label.textColor = .black
        return label
    }()
    
    private var taskDTO: TaskDTO?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setUpConstraints()
        setUpLongPressGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpContents(taskDTO: TaskDTO) {
        self.taskDTO = taskDTO
        
        titleLabel.text = taskDTO.title
        descriptionLabel.text = taskDTO.description
        deadlineLabel.text = taskDTO.deadline
        deadlineLabel.textColor = taskDTO.isPassDeadline ? .red : .black
    }
    
    private func configureUI() {
        [titleLabel, descriptionLabel, deadlineLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        
        contentView.addSubview(stackView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
        
        descriptionLabel.setContentHuggingPriority(.init(1), for: .vertical)
    }
    
    private func setUpLongPressGesture() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress))
        
        addGestureRecognizer(longPressGesture)
    }
    
    @objc
    private func didLongPress() {
        guard let taskDTO = taskDTO else { return }
        
        delegate?.didLongPressCell(taskDTO: taskDTO, cellFrame: frame)
    }
}
