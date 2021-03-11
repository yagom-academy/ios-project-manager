//
//  ThingTableViewCell.swift
//  ProjectManager
//
//  Created by 리나 on 2021/03/10.
//

import UIKit

class ThingTableViewCell: UITableViewCell {
    
    // MARK: - Property
    
    static var identifier: String {
        return "\(self)"
    }
    var isDone: Bool = false
    
    // MARK: - Outlet
    
    private let titleLabel: UILabel = makeLabel(textSize: .title3)
    private let bodyLabel: UILabel = makeLabel(textColor: .gray, numberOfLines: 3)
    private let dateLabel: UILabel = makeLabel(textSize: .caption1)
    
    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configuerConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configuerConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        bodyLabel.text = nil
        dateLabel.text = nil
        dateLabel.textColor = UIColor.label
    }
    
    // MARK: - UI
    
    static private func makeLabel(textColor: UIColor = .black, textSize: UIFont.TextStyle = .body, numberOfLines: Int = 1) -> UILabel {
        let label = UILabel()
        label.textColor = textColor
        label.font = .preferredFont(forTextStyle: textSize)
        label.numberOfLines = numberOfLines
        return label
    }
    
    private func configuerConstraints() { // TODO: 함수명 오타수정.
        let stackView = UIStackView()
        contentView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(bodyLabel)
        stackView.addArrangedSubview(dateLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    func configureCell(_ thing: Thing) {
        titleLabel.text = thing.title
        bodyLabel.text = thing.body
        dateLabel.text = thing.dateString
        changeDateColor(date: thing.date)
    }
    
    private func changeDateColor(date: Date) {
        if isDone == false, date < Date() {
            dateLabel.textColor = .red
        }
    }
}
