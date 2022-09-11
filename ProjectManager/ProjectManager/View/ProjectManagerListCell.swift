//
//  ProjectManagerListCell.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/11.
//

import UIKit

final class ProjectManagerListCell: UITableViewCell {
    static let identifier = "ProjectManagerListCell"
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 5
        
        return stackView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "제목입니다"
        label.numberOfLines = 1
        label.font = .preferredFont(forTextStyle: .title3)
        
        return label
    }()
    
    private var bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = """
            바디입니다
            바디입니다
            바디입니다
            바디입니다
            바디입니다
            """
        label.numberOfLines = 3
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .gray
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        return label
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "날짜입니다"
        label.numberOfLines = 1
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .gray
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureUI() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(bodyLabel)
        stackView.addArrangedSubview(dateLabel)
        
        let inset = CGFloat(10)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                    constant: inset),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                    constant: -inset),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                               constant: inset),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                  constant: -inset)
        ])
    }
}
