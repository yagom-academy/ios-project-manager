//
//  CardsTableViewCell.swift
//  ProjectManager
//
//  Created by Kyungmin Lee on 2021/04/09.
//

import UIKit

class CardsTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionsLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    
    class var identifier: String {
        return "\(self)"
    }
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            dateFormatter.locale = appDelegate.locale
        }
        return dateFormatter
    }()
    private var locale: Locale {
        if let language = Locale.preferredLanguages.first {
            return Locale(identifier: language)
        } else {
            return Locale.current
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        titleLabel.text = ""
        descriptionsLabel.text = ""
        deadlineLabel.text = ""
    }
    
    func configure(card: Card) {
        titleLabel.text = card.title
        descriptionsLabel.text = card.descriptions
        if let date = card.deadlineDate {
            deadlineLabel.text = dateFormatter.string(from: date)
            if card.status != .done {
                deadlineLabel.textColor = (date < Date()) ? .systemRed : .label
            }
        }
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.systemGray2.cgColor
    }
}
