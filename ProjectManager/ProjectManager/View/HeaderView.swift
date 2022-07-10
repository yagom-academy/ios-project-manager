//
//  HeaderView.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/06.
//

import UIKit

final class HeaderView: UIView {
    init(_ menuType: ListType) {
        super.init(frame: .zero)
        titleLabel.text = menuType.title
        setInitailView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel,
                                                       countLabel])
        stackView.spacing = 5
        
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        
        return label
    }()
    
    private(set) lazy var countLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .label
        label.textColor = .systemBackground
        label.layer.cornerRadius = 20
        label.clipsToBounds = true
        
        return label
    }()
}

// MARK: - view setting func
extension HeaderView {
    private func setInitailView() {
        self.backgroundColor = .systemGray6
        self.addSubview(mainStackView)
        mainStackView.snp.makeConstraints{
            $0.top.leading.bottom.equalToSuperview().inset(10)
            $0.trailing.lessThanOrEqualToSuperview()
        }
        
        countLabel.snp.makeConstraints{
            $0.height.equalTo(countLabel.snp.width)
        }
    }
}
