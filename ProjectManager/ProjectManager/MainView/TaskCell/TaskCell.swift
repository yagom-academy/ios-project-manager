//
//  TodoCell.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/19.
//

import UIKit
import Combine

final class TaskCell: UICollectionViewListCell {
    static let identifier = "TaskCell"
    
    let titleLabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    let bodyLabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .systemGray
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
    
    let stackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private var viewModel: TaskCellViewModel?
    private var bindings: [AnyCancellable] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContentLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func provide(viewModel: TaskCellViewModel) {
        self.viewModel = viewModel
        bindViewModelToView()
    }
    
    private func bindViewModelToView() {
        viewModel?.$title
            .sink { title in
                self.titleLabel.text = title
            }
            .store(in: &bindings)
        
        viewModel?.$body
            .sink { body in
                self.bodyLabel.text = body
            }
            .store(in: &bindings)
        
        viewModel?.$date
            .sink { date in
                self.dateLabel.text = date
            }
            .store(in: &bindings)
        
        viewModel?.$isDateExpired
            .sink { state in
                guard let state else { return }
                
                self.dateLabel.textColor = state ? .systemRed : .black
            }
            .store(in: &bindings)
    }
    
    private func configureContentLayout() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(bodyLabel)
        stackView.addArrangedSubview(dateLabel)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
