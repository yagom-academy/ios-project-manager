//
//  TableSectionHeaderView.swift
//  ProjectManager
//
//  Created by Finnn on 2022/09/09.
//

import UIKit
import RxSwift
import RxCocoa

final class TableSectionHeaderView: UIView {
    
    // MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.text = "Default Title"
        
        return label
    }()
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.layer.cornerRadius = label.font.pointSize
        label.backgroundColor = .black
        label.textAlignment = .center
        label.clipsToBounds = true
        label.textColor = .white
        label.text = "77"
        
        return label
    }()
    
    private let blankView: UIView = {
        let view = UIView()

        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        return stackView
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        
        return view
    }()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .systemGray6
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure Methods

extension TableSectionHeaderView {    
    private func configureHierarchy() {
        addSubview(stackView)
        addSubview(separatorView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(countLabel)
        stackView.addArrangedSubview(blankView)
    }
    
    private func configureLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: 15
            ),
            stackView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -15
            ),
            stackView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 15
            ),
            stackView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -15
            )
        ])
        
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countLabel.widthAnchor.constraint(equalTo: countLabel.heightAnchor)
        ])
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            separatorView.heightAnchor.constraint(equalToConstant: 3),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -1
            )
        ])
    }
}

// MARK: - Setter Methods

extension TableSectionHeaderView {
    func set(title: String) {
        self.titleLabel.text = title
    }
}
