//
//  TableItem.swift
//  ProjectManager
//
//  Created by 강경 on 2021/06/29.
//

import UIKit

// TODO: - item 구성이름(title,date,summary) 서버side 이름과 통일시켜야 함
struct TableItem {
    let title: String
    let summary: String
    let date: Double
    
    init(title: String,
         summary: String,
         date: Double) {
        self.title = title
        self.summary = summary
        self.date = date
    }
}
