//
//  HeaderView.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/06.
//

import UIKit
enum MenuType {
    case todo
    case doing
    case done
    
    var title: String {
        switch self {
        case .todo:
            return "TODO"
        case .doing:
            return "DOING"
        case .done:
            return "DONE"
        }
    }
}
final class HeaderVIew: UIView {
    init(_ menuType: MenuType) {
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
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .label
        label.textColor = .systemBackground
        label.layer.cornerRadius = 20
        label.clipsToBounds = true
        label.text = "999"
        
        return label
    }()
    
    private func setInitailView() {
        self.backgroundColor = .systemGray6
        self.addSubview(mainStackView)
        mainStackView.snp.makeConstraints{
            $0.top.leading.bottom.equalToSuperview().inset(10)
        }
        
        countLabel.snp.makeConstraints{
            $0.height.equalTo(countLabel.snp.width)
        }
    }
}
