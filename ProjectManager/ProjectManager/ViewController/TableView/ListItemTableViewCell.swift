//
//  ListTableViewCell.swift
//  ProjectManager
//
//  Created by sole on 2021/03/09.
//

import UIKit

class ListItemTableViewCell: UITableViewCell {
    static var identifier: String {
        return "\(self)"
    }
    private let contentsContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.systemGray4.cgColor
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 1
        view.layer.shadowOpacity = 1
        return view
    }()
    lazy var titleLabel: UILabel = makeCellLabel(font: .title3, textColor: .black)
    lazy var descriptionLabel: UILabel = makeCellLabel(font: .body, textColor: .gray, numberOfLines: 3)
    lazy var deadLineLabel: UILabel = makeCellLabel(font: .callout, textColor: .black)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
        configureContentsContainerView()
        configureAutoLayout()
    }
    
    private func configureCell() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
    }
    
    private func makeCellLabel(font: UIFont.TextStyle, textColor: UIColor, numberOfLines: Int = 1) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: font)
        label.textColor = textColor
        label.numberOfLines = numberOfLines
        return label
    }
    
    private func configureContentsContainerView() {
        contentsContainerView.addSubview(titleLabel)
        contentsContainerView.addSubview(descriptionLabel)
        contentsContainerView.addSubview(deadLineLabel)
        contentView.addSubview(contentsContainerView)
    }
    
    private func configureAutoLayout() {
        NSLayoutConstraint.activate([
            contentsContainerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            contentsContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentsContainerView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1),
            contentsContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            titleLabel.topAnchor.constraint(equalTo: contentsContainerView.topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: contentsContainerView.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: contentsContainerView.widthAnchor, multiplier: 0.9),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            descriptionLabel.centerXAnchor.constraint(equalTo: contentsContainerView.centerXAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: contentsContainerView.widthAnchor, multiplier: 0.9),
            
            deadLineLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            deadLineLabel.bottomAnchor.constraint(equalTo: contentsContainerView.bottomAnchor, constant: -10),
            deadLineLabel.centerXAnchor.constraint(equalTo: contentsContainerView.centerXAnchor),
            deadLineLabel.widthAnchor.constraint(equalTo: contentsContainerView.widthAnchor, multiplier: 0.9)
        ])
    }
    
    func fillLabelsText(item: Todo, statusType: ItemStatus) {
        titleLabel.text = item.title
        descriptionLabel.text = item.descriptions
        
        guard let date = item.deadLine else {
            deadLineLabel.text = "마감 기한 없음"
            return
        }
        
        if statusType != .done {
            if date < Date() {
                deadLineLabel.textColor = .red
            }
        }
        
        deadLineLabel.text = date.toString
    }
    
    override func prepareForReuse() {
        titleLabel.text = ""
        descriptionLabel.text = ""
        deadLineLabel.text = ""
        deadLineLabel.textColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
