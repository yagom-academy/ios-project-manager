//
//  Extension.swift
//  ProjectManager
//
//  Created by 리나 on 2021/03/10.
//

import UIKit

// MARK: - DateFormatter

extension DateFormatter {
    func convertToUserLocaleString(date: Date) -> String {
        var locale = Locale.autoupdatingCurrent.identifier
        if let collatorLocale = Locale.autoupdatingCurrent.collatorIdentifier {
            locale = collatorLocale
        }
        self.dateStyle = .medium
        self.timeStyle = .none
        self.locale = Locale(identifier: locale)
        let dateString = self.string(from: date)
        return dateString
    }
}

// MARK: - String

extension String {
    static let empty = ""
}

// MARK: - UILabel

extension UILabel {
    func configure(textColor: UIColor = .black, textSize: UIFont.TextStyle = .body, numberOfLines: Int = 1) {
        self.textColor = textColor
        self.font = .preferredFont(forTextStyle: textSize)
        self.numberOfLines = numberOfLines
    }
}
