//
//  Date+Extension.swift
//  ProjectManager
//
//  Created by 1 on 2022/03/08.
//

import Foundation

extension Date {
    
    static let localeDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        var preferredLanguage = Locale.preferredLanguages.first
        let currentRegionIdentifier: Substring? = NSLocale.current.identifier.split(separator: "_").last
        if let languageCode = preferredLanguage, let regionCode = currentRegionIdentifier {
            let deviceLocaleIdentifier = "\(languageCode)_\(regionCode)"
            dateFormatter.locale = Locale(identifier: deviceLocaleIdentifier)
            return dateFormatter
        }
        dateFormatter.locale = .autoupdatingCurrent
        return dateFormatter
    }()
    
    func localeString() -> String {
        return Date.localeDateFormatter.string(from: self)
    }
}
