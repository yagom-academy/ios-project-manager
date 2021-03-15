//
//  MainTitleView.swift
//  ProjectManager
//
//  Created by 임성민 on 2021/03/16.
//

import UIKit

class MainTitleView: UIView {
    
    // MARK: - Outlet
    
    private let titleLabel = UILabel()
    private let connectionLabel = UILabel()
    private let connectionLabelDiameter: CGFloat = 16
    var isConnected: Bool = false {
        didSet {
            changeConnectionLabelColor()
        }
    }
    
    // MARK: - Init
    
    init(title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
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
        addSubview(connectionLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        connectionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            connectionLabel.widthAnchor.constraint(equalToConstant: connectionLabelDiameter),
            connectionLabel.heightAnchor.constraint(equalToConstant: connectionLabelDiameter),
            connectionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            connectionLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8)
        ])
    }
    
    private func setStyle() {
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        connectionLabel.textAlignment = .center
        connectionLabel.backgroundColor = .red
        connectionLabel.layer.cornerRadius = connectionLabelDiameter/2
        connectionLabel.layer.masksToBounds = true
    }
    
    private func changeConnectionLabelColor() {
        var color: UIColor
        if isConnected {
            color = .systemGreen
        } else {
            color = .systemRed
        }
        connectionLabel.backgroundColor = color
    }
}
