//
//  ListTableViewCell.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/06.
//

import UIKit

final class ListTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private lazy var sectionView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        
        return view
    }()
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topStackView,
                                                       deadlineLabel])
        stackView.axis = .vertical
        stackView.spacing = 5

        return stackView
    }()
    
    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel,
                                                      bodyLabel])
        stackView.axis = .vertical
        stackView.spacing = 3
        
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.setContentHuggingPriority(.required, for: .vertical)
        
        return label
    }()
    
    private lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.numberOfLines = 3
        
        return label
    }()
    
    private lazy var deadlineLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
}

// MARK: - view setting func
extension ListTableViewCell {
    func setViewContents(_ listItem: ListItem, isOver: Bool) {
        self.backgroundColor = .systemGray6
        titleLabel.text = listItem.title
        bodyLabel.text = listItem.body
        deadlineLabel.text = DateConverter.listDateString(listItem.deadline)
        deadlineLabel.textColor = isOver ? .red : .label
    }
    
    private func setViewLayout() {
        self.addSubview(sectionView)
        sectionView.snp.makeConstraints{
            $0.top.equalToSuperview().inset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        sectionView.addSubview(mainStackView)
        mainStackView.snp.makeConstraints{
            $0.edges.equalToSuperview().inset(15)
        }
    }
}
