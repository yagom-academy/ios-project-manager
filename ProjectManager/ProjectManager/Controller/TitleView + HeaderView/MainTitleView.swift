//
//  MainTitleView.swift
//  ProjectManager
//
//  Created by 임성민 on 2021/03/16.
//

import UIKit
import Network

final class MainTitleView: UIView {
    
    // MARK: - Property
    
    private let connectionLabelDiameter: CGFloat = 15
    var isConnected: Bool = false {
        didSet {
            changeConnectionLabelColor()
        }
    }
    
    // MARK: - Outlet
    
    private let titleLabel = UILabel()
    private let connectionLabel = UILabel()
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        titleLabel.text = Strings.navigationTitle
        configureConstraints()
        setStyle()
        setNetworkConnection()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureConstraints()
        setStyle()
        setNetworkConnection()
    }
    
    // MARK: - UI
    
    private func configureConstraints() {
        addSubview(titleLabel)
        addSubview(connectionLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        connectionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 10),
            
            connectionLabel.widthAnchor.constraint(equalToConstant: connectionLabelDiameter),
            connectionLabel.heightAnchor.constraint(equalToConstant: connectionLabelDiameter),
            connectionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            connectionLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 5)
        ])
    }
    
    private func setStyle() {
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        connectionLabel.font = .systemFont(ofSize: 15)
        connectionLabel.backgroundColor = .red
        connectionLabel.layer.cornerRadius = connectionLabelDiameter/2
        connectionLabel.layer.masksToBounds = true
    }
    
    private func changeConnectionLabelColor() {
        if isConnected {
            connectionLabel.backgroundColor = .systemGreen
        } else {
            connectionLabel.backgroundColor = .red
        }
    }
    
    private func setNetworkConnection() {
        isConnected = NetworkMonitor.shared.isConnected
        NotificationCenter.default.addObserver(self, selector: #selector(setIsConnectedTrue), name: NSNotification.Name(Strings.networkConnectNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setIsConnectedFalse), name: NSNotification.Name(Strings.networkDisconnectNotification), object: nil)
    }
    
    @objc func setIsConnectedTrue() {
        self.isConnected = true
    }
    
    @objc func setIsConnectedFalse() {
        self.isConnected = false
    }
}
