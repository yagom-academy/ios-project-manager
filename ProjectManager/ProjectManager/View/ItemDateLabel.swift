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
    
    func setTextColor(by date: String) {
        // TODO: 하나의 데이터 처리 객체 만들기
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: Locale.current.identifier)
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let currentDate = dateFormatter.string(from: Date())
        if currentDate <= date {
            self.textColor = .black
        } else {
            self.textColor = .systemRed
        }
    }
}
