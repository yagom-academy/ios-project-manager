//
//  HeaderView.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/17.
//

import UIKit
import Combine

final class HeaderView: UICollectionReusableView {
    private let titleLabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        return label
    }()
    
    private let badgeLabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .black
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.required, for: .horizontal)
        
        return label
    }()
    
    private let stackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private var viewModel: HeaderViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func provide(viewModel: HeaderViewModel) {
        self.viewModel = viewModel
        self.titleLabel.text = viewModel.titleText
        self.badgeLabel.text = viewModel.badgeText
        bindViewModelToView()
    }
    
    private func bindViewModelToView() {
        viewModel?.badgeTextPublisher
            .map { String($0) }
            .sink { [weak self] badgeText in
                guard let self else { return }
                
                self.badgeLabel.text = badgeText
            }
            .store(in: &cancellables)
    }
    
    private func configureLayout() {
        self.backgroundColor = .systemGray6
        self.addSubview(stackView)
        self.layer.addBorder([.bottom], color: .systemGray3, width: 0.8)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(badgeLabel)
        stackView.addArrangedSubview(UIView())
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            stackView.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor),
            stackView.bottomAnchor.constraint(greaterThanOrEqualTo: self.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            badgeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 20)
        ])
    }
}
