//
//  Extension.swift
//  ProjectManager
//
//  Created by 리나 on 2021/03/10.
//

import UIKit
import MobileCoreServices

// MARK: - DateFormatter

extension DateFormatter {
    static func convertToUserLocaleString(date: Date) -> String {
        let dateFormatter = self.init()
        var locale = Locale.autoupdatingCurrent.identifier
        if let collatorLocale = Locale.autoupdatingCurrent.collatorIdentifier {
            locale = collatorLocale
        }
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: locale)
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    static func convertToUserLocaleStringWithTime(date: Date) -> String {
        let dateFormatter = self.init()
        var locale = Locale.autoupdatingCurrent.identifier
        if let collatorLocale = Locale.autoupdatingCurrent.collatorIdentifier {
            locale = collatorLocale
        }
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .medium
        dateFormatter.locale = Locale(identifier: locale)
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}

// MARK: - String

extension String {
    static let empty = ""
}

// MARK: - NSItemProvider

extension NSItemProvider {
    static func makeJSONItemProvider(data: Data?, _ completionHandler: @escaping () -> Void) -> NSItemProvider {
        let itemProvider = self.init()
        itemProvider.registerDataRepresentation(forTypeIdentifier: kUTTypeJSON as String, visibility: .all) { (loadHandler) -> Progress? in
            loadHandler(data, nil)
            completionHandler()
            return nil
        }
        return itemProvider
    }
}
