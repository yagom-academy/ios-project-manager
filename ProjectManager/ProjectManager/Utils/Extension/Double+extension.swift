//
//  Double+extension.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/07.
//

import Foundation

extension Double {
    var formattedString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.locale = Locale(
            identifier: Locale.preferredLanguages.first ?? "ko_KR"
        )
        return dateFormatter.string(
            from: Date(
                timeIntervalSince1970: self
            )
        )
    }
}
