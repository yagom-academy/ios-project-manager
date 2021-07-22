//
//  Task+NSItemProviderWriting.swift
//  ProjectManager
//
//  Created by Ryan-Son on 2021/07/22.
//

import Foundation
import MobileCoreServices

extension Task: NSItemProviderWriting {

    static var writableTypeIdentifiersForItemProvider: [String] {
        return [kUTTypeJSON as String]
    }

    func loadData(withTypeIdentifier typeIdentifier: String,
                  forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
        if typeIdentifier == kUTTypeJSON as String {
            guard let draggedTask = try? JSONEncoder().encode(self) else {
                completionHandler(nil, PMError.cannotEncodeToJSON)
                return nil
            }
            completionHandler(draggedTask, nil)
        } else {
            completionHandler(nil, PMError.invalidTypeIdentifier)
        }

        return nil
    }
}
