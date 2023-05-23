//
//  HeaderView.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/23.
//

import UIKit

final class HeaderView: UIView {
    private let title = UILabel()
    private let countLabel = CircleLabel()

    init(text: String, frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemGray5
        self.addSubview(title)
        self.addSubview(countLabel)
        title.text = text
        title.font = UIFont.preferredFont(forTextStyle: .largeTitle)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let titleY = (bounds.height - title.frame.height) / 2
        
        let countLabelX = title.frame.size.width + 10
        let countLabelY = (bounds.height - countLabel.frame.height) / 2
        let width = bounds.height * 0.7
        
        title.frame = CGRect(x: 0, y: titleY, width: bounds.width, height: title.frame.height)
        title.sizeToFit()
        
        countLabel.frame = CGRect(x: countLabelX, y: countLabelY, width: width, height: width)
    }

    func changeCount(_ count: String) {
        countLabel.changeText(count: count)
    }
}
