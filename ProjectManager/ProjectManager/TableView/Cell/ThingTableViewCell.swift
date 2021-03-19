//
//  ThingTableViewCell.swift
//  ProjectManager
//
//  Created by 리나 on 2021/03/10.
//

import UIKit

final class ThingTableViewCell: UITableViewCell, Reusable {
    
    // MARK: - Outlet
    
    private let titleLabel = Label(textSize: .title3)
    private let descriptionLabel = Label(textColor: .gray, numberOfLines: 3)
    private let dateLabel = Label(textSize: .caption1)
    
    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        descriptionLabel.text = nil
        dateLabel.text = nil
        dateLabel.textColor = .label
    }
    
    // MARK: - UI
    
    private func configureConstraints() {
        let spacingView = UIView()
        spacingView.backgroundColor = .systemGroupedBackground
        spacingView.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, dateLabel])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(spacingView)
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            spacingView.heightAnchor.constraint(equalToConstant: 5),
            spacingView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            spacingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            spacingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            
            stackView.topAnchor.constraint(equalTo: spacingView.bottomAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configureCell(_ thing: Thing) {
        titleLabel.text = thing.title
        descriptionLabel.text = thing.detailDescription
        dateLabel.text = thing.dateString
        if thing.state != Strings.doneState {
            changeDateColor(date: thing.date)
        }
    }
    
    private func changeDateColor(date: Date) {
        if date < Date() {
            dateLabel.textColor = .red
        } else {
            dateLabel.textColor = .label
        }
    }
}
