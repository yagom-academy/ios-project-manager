//
//  String+Extension.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 19/07/2022.
//

import Foundation

extension String {
    static let dateFormatter = DateFormatter()
    
    var toDate: Date? {
        String.dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = String.dateFormatter.date(from: self)
        
        return date
    }
}
