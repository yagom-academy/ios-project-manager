//
//  TableViewCell.swift
//  ProjectManager
//
//  Created by 김찬우 on 2021/07/02.
//

import UIKit

class ScheduleCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let titleLabel: UILabel = {
            let titleLabel = UILabel()
            titleLabel.backgroundColor = .blue
            titleLabel.text = "title"
            titleLabel.lineBreakMode = .byTruncatingTail
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            
            return titleLabel
        }()

        let descriptionLabel: UILabel = {
            let descriptionLabel = UILabel()
            descriptionLabel.backgroundColor = .yellow
            descriptionLabel.text = """
I'm on the next level yeah절대적 룰을 지켜내 손을놓지말아결속은 나의 무기광야로 걸어가알아 네 homeground위협에 맞서서제껴라 제껴라 제껴라상상도 못한 black out유혹은 깊고 진해(Too hot too hot)(Ooh ooh wee) 맞잡은 손을 놓쳐난 절대 포기 못해I'm on the next level저 너머의 문을 열어Next level널 결국엔 내가 부셔Next levelKosmo에 닿을 때까지Next level제껴라 제껴라 제껴라
"""
            descriptionLabel.numberOfLines = 3
            descriptionLabel.lineBreakMode = .byTruncatingTail
            descriptionLabel.textColor = .black
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

            return descriptionLabel
        }()

        let dateLabel: UILabel = {
            let dateLabel = UILabel()
            dateLabel.backgroundColor = .red
            dateLabel.text = "date"
            dateLabel.translatesAutoresizingMaskIntoConstraints = false

            return dateLabel
        }()
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(dateLabel)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: dateLabel.bottomAnchor),
        
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            descriptionLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            
            dateLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            dateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
