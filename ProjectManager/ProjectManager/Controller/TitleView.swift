//
//  TitleView.swift
//  ProjectManager
//
//  Created by 리나 on 2021/03/16.
//

import UIKit

final class TitleView: UIView {
    
    // MARK: - Property
    
    var isConnected: Bool = false {
        didSet {
            changeConnectionLabelColor()
        }
    }
    
    // MARK: - Outlet
    
    private let titleLabel = UILabel()
    private let countLabel = UILabel()
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        titleLabel.text = Strings.navigationTitle
        configureConstraints()
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureConstraints()
        setStyle()
    }
    
    // MARK: - UI
    
    private func configureConstraints() {
        addSubview(titleLabel)
        addSubview(countLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 10),
            
            countLabel.widthAnchor.constraint(equalToConstant: 20),
            countLabel.heightAnchor.constraint(equalToConstant: 20),
            countLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            countLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 5)
        ])
    }
    
    private func setStyle() {
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        countLabel.font = .systemFont(ofSize: 15)
        countLabel.backgroundColor = .red
        countLabel.layer.cornerRadius = 10
        countLabel.layer.masksToBounds = true
    }
    
    private func changeConnectionLabelColor() {
        if isConnected {
            countLabel.backgroundColor = .green
        } else {
            countLabel.backgroundColor = .red
        }
    }
}
