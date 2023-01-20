//
//  HeaderView.swift
//  ProjectManager
//
//  Created by Hamo, Wonbi on 2023/01/12.
//

import UIKit

final class HeaderView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let countLabel: CountLabel = {
        let countLabel = CountLabel()
        countLabel.text = "0"
        countLabel.textAlignment = .center
        countLabel.textColor = .white
        countLabel.backgroundColor = .black
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        return countLabel
    }()
    
    private let headerViewModel: HeaderViewModel
    
    init(viewModel: HeaderViewModel) {
        headerViewModel = viewModel
        
        super.init(frame: .zero)
        configureView()
        configureLayout()
        bindHeaderViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        self.backgroundColor = .systemBackground
        
        addSubview(titleLabel)
        addSubview(countLabel)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            countLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            countLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            countLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, multiplier: 0.8),
            countLabel.widthAnchor.constraint(greaterThanOrEqualTo: titleLabel.heightAnchor, multiplier: 0.8)
        ])
    }
    
    private func bindHeaderViewModel() {
        headerViewModel.cellCountHandler = { [weak self] count in
            self?.countLabel.text = count
        }
        
        headerViewModel.titleHandler = { [weak self] title in
            self?.titleLabel.text = title
        }
    }
}
