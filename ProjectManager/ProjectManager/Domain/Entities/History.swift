//
//  History.swift
//  ProjectManager
//
//  Created by JINHONG AN on 2021/11/12.
//

import Foundation

enum UpdateType: String {
    case create = "생성"
    case delete = "삭제"
    case modify = "수정"
    
    var description: String {
        return self.rawValue
    }
}

struct History: Identifiable {
    var id = UUID()
    var title = ""
    var date = Date()
    var updateType = UpdateType.create
}
