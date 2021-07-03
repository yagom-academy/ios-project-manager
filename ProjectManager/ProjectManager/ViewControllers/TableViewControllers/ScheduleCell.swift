//
//  TableViewCell.swift
//  ProjectManager
//
//  Created by 김찬우 on 2021/07/02.
//

import UIKit

class ScheduleCell: UITableViewCell {

    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    var dateLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stackView: UIStackView = {
            let stackView = UIStackView()
            
            stackView.axis = .vertical
            stackView.alignment = .leading
            stackView.distribution = .fill
            stackView.spacing = 5
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            return stackView
        }()
        
        self.titleLabel = {
            let titleLabel = UILabel()
            
            titleLabel.text = "title"
            titleLabel.font = UIFont.preferredFont(forTextStyle: .title2)
            titleLabel.lineBreakMode = .byTruncatingTail
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            
            return titleLabel
        }()

        self.descriptionLabel = {
            let descriptionLabel = UILabel()
            
            descriptionLabel.text = """
                I'm on the next level yeah절대적 룰을 지켜내 손을놓지말아결속은 나의 무기광야로 걸어가알아 네 homeground위협에 맞서서제껴라 제껴라 제껴라상상도 못한 black out유혹은 깊고 진해(Too hot too hot)(Ooh ooh wee) 맞잡은 손을 놓쳐난 절대 포기 못해I'm on the next level저 너머의 문을 열어Next level널 결국엔 내가 부셔Next levelKosmo에 닿을 때까지Next level제껴라 제껴라 제껴라
                """
            descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
            descriptionLabel.numberOfLines = 3
            descriptionLabel.lineBreakMode = .byTruncatingTail
            descriptionLabel.textColor = .systemGray
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

            return descriptionLabel
        }()

        self.dateLabel = {
            let dateLabel = UILabel()
            
            dateLabel.text = "date"
            dateLabel.font = UIFont.preferredFont(forTextStyle: .body)
            dateLabel.translatesAutoresizingMaskIntoConstraints = false

            return dateLabel
        }()
        
        contentView.backgroundColor = .white
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(dateLabel)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: -10),
            contentView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            contentView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -15),
            contentView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 10)
        ])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected { contentView.backgroundColor = .systemGray3 }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
