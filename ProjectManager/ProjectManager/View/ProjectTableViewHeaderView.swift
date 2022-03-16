//
//  ProjectTableViewHeaderView.swift
//  ProjectManager
//
//  Created by 1 on 2022/03/08.
//

import UIKit

class ProjectTableViewHeaderView: UIView {

    // MARK: - UIProperty
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title1)
        label.textAlignment = .left
        return label
    }()
    
    // TODO: - 동그라미 레이블로 수정
    private let projectCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .black
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = 9
        label.layer.cornerCurve = .circular
        label.layer.masksToBounds = true
        return label
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(statusLabel)
        self.addSubview(projectCountLabel)
        self.configureLayout()
    }
  
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure Layout
    private func configureLayout() {
        NSLayoutConstraint.activate([
            statusLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 7)
        ])
        NSLayoutConstraint.activate([
            projectCountLabel.leadingAnchor.constraint(equalTo: statusLabel.trailingAnchor, constant: 7),
            projectCountLabel.centerYAnchor.constraint(equalTo: statusLabel.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            projectCountLabel.heightAnchor.constraint(equalToConstant: 18),
            projectCountLabel.widthAnchor.constraint(equalToConstant: 18)])
    }
    
    // MARK: - API
    func configureContent(status: String?, projectCount: Int ) {
        self.statusLabel.text = status
        self.projectCountLabel.text = String(projectCount)
    }
}
