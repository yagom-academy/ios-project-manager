//
//  Task+NSItemProviderReading.swift
//  ProjectManager
//
//  Created by Ryan-Son on 2021/07/22.
//

import Foundation
import MobileCoreServices

extension Task: NSItemProviderReading {

    static var readableTypeIdentifiersForItemProvider: [String] {
        return [kUTTypeJSON as String]
    }

    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Task {
        if typeIdentifier == kUTTypeJSON as String {
            let droppedTask = try JSONDecoder().decode(Task.self, from: data)
            return droppedTask
        } else {
            throw PMError.invalidTypeIdentifier
        }
    }
}
