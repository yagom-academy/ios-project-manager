//
//  Formatter.swift
//  ProjectManager
//
//  Created by Eddy on 2022/07/10.
//

import Foundation

struct Formatter {
    static let date: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.locale = .autoupdatingCurrent

        return dateFormatter
    }()
    
    private init() {}
}
