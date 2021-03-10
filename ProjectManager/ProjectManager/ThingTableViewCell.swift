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
    
    private let titleLabel: UILabel = makeLabel()
    private let bodyLabel: UILabel = makeLabel()
    private let dateLabel: UILabel = makeLabel()
    
    // MARK: - UI
    
    static private func makeLabel(textColor: UIColor = .black, textSize: UIFont.TextStyle = .body) -> UILabel {
        let label = UILabel()
        label.textColor = textColor
        label.font = .preferredFont(forTextStyle: textSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
