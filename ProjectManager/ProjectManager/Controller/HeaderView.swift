//
//  HeaderView.swift
//  ProjectManager
//
//  Created by 김태형 on 2021/04/01.
//
import UIKit

class HeaderView: UIView {
    
    init(_ count: Int, title: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: 30, height: 50))
        configureConstraints()
        setLabelStyle()
        titleLabel.text = title
        numberLabel.text = String(count)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private var titleLabel = UILabel()
    var numberLabel = UILabel()
    
    private func setLabelStyle() {
        backgroundColor = .systemGray4
        titleLabel.font = .preferredFont(forTextStyle: .title1)
        numberLabel.font = .systemFont(ofSize: 20)
        numberLabel.textColor = .white
        numberLabel.textAlignment = .center
        numberLabel.backgroundColor = .black
        numberLabel.layer.cornerRadius = 10
        numberLabel.adjustsFontSizeToFitWidth = true
        numberLabel.layer.masksToBounds = true
        
    }
    
    private func configureConstraints() {
        addSubview(titleLabel)
        addSubview(numberLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            numberLabel.widthAnchor.constraint(equalToConstant: 20),
            numberLabel.heightAnchor.constraint(equalToConstant: 20),
            numberLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            numberLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 5)
        ])
    }
}
