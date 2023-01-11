//
//  ProcessStackView.swift
//  ProjectManager
//
//  Created by parkhyo on 2023/01/11.
//

import UIKit

final class ProcessStackView: UIStackView {
    private let processLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        return label
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [processLabel, countLabel])
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fill
        return stackView
    }()
    
    private var tableView = UITableView()
    
    init(process: Process) {
        super.init(frame: .zero)
        self.processLabel.text = process.titleValue
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProcessStackView {
    private func setupView() {
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fill
        self.translatesAutoresizingMaskIntoConstraints = false
        [titleStackView, tableView].forEach(self.addSubview(_:))
    }
}
