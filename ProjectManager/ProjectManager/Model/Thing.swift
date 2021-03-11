//
//  Thing.swift
//  ProjectManager
//
//  Created by 임성민 on 2021/03/09.
//

import Foundation

struct Thing: Codable {
    let title: String
    let body: String // TODO: description으로 변수명 바꾸기
    let date: Date
    var dateString: String {
        return DateFormatter().convertToUserLocaleString(date: date)
    }
    var date2: Int {
        return 1
    }

//    enum CodingKeys: String, CodingKey {
//        case title,
//    }
}
