//
//  History.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/22.
//

import Foundation

struct History {
    let action: String
    let time: Double
    
    func timeDescription() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .medium
        dateFormatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        dateFormatter.locale = Locale(
            identifier:
                Locale.current.identifier
        )
        return dateFormatter.string(from: Date(timeIntervalSince1970: self.time))
    }
}
