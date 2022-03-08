//
//  ProjectTableViewHeaderView.swift
//  ProjectManager
//
//  Created by 1 on 2022/03/08.
//

import UIKit

class ProjectTableViewHeaderView: UITableViewHeaderFooterView {

    // MARK: - UIProperty
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title1)
        label.textAlignment = .left
        return label
    }()
    
    private let projectCountLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = label.bounds.size.width * 0.5
        label.backgroundColor = .black
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [statusLabel, projectCountLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    // MARK: - Initializer
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure Layout
    private func configureLayout() {
        NSLayoutConstraint.activate([
            projectCountLabel.leadingAnchor.constraint(equalTo: statusLabel.readableContentGuide.trailingAnchor),
            projectCountLabel.bottomAnchor.constraint(equalTo: statusLabel.firstBaselineAnchor)
        ])
    }
    
    // MARK: - API
    func configureContent(status: String?, projectCount: String? ) {
        self.statusLabel.text = status
        self.projectCountLabel.text = projectCount
    }
}
