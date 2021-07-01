//
//  ProjectManagerCellStackView.swift
//  ProjectManager
//
//  Created by kio on 2021/07/01.
//

import UIKit

class ProjectManagerCellStackView: UIStackView {

    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let dateLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStackView()
        configureLabel()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureStackView() {
        axis = .vertical
        alignment = .fill
        distribution = .fill
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureLabel() {
        addArrangedSubview(titleLabel)
        addArrangedSubview(descriptionLabel)
        addArrangedSubview(dateLabel)
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        descriptionLabel.font = UIFont.systemFont(ofSize: 15)
        descriptionLabel.textColor = .systemGray
        dateLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        
        titleLabel.numberOfLines = 1
        descriptionLabel.numberOfLines = 3
        dateLabel.numberOfLines = 1
        
        titleLabel.text = "금연하기"
        descriptionLabel.text = "담배냄새는 소개팅에서 마이너스, 담배냄새는 소개팅에서 마이너스, 담배냄새는 소개팅에서 마이너스,담배냄새는 소개팅에서 마이너스, 담배냄새는 소개팅에서 마이너스, 담배냄새는 소개팅에서 마이너스, 담배냄새는 소개팅에서 마이너스"
        dateLabel.text = "2021.07.01"
    }
}
