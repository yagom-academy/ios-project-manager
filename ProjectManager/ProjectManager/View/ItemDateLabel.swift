//
//  ItemDateLabel.swift
//  ProjectManager
//
//  Created by 이영우 on 2021/07/22.
//

import UIKit

class ItemDateLabel: UILabel {
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.numberOfLines = 1
        self.lineBreakMode = .byTruncatingTail
        self.font = UIFont.preferredFont(forTextStyle: .title1)
    }
    
    func setText(_ date: Double) {
        let currentDate = Date()
        let current = Double(currentDate.timeIntervalSince1970)
        if current > date {
            self.textColor = .black
        } else if current < date {
            self.textColor = .systemRed
        }
        
        // TODO: 하나의 데이터 처리 객체 만들기
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: Locale.current.identifier)
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let dateText = dateFormatter.string(from: Date(timeIntervalSince1970: date))
        
        self.text = dateText
    }
}
