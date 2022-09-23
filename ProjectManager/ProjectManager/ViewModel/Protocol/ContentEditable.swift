//
//  ContentEditable.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/17.
//

import Foundation

protocol ContentEditable {
    func fetch(_ indexPath: Int) -> ProjectUnit?
    func edit(indexPath: Int, title: String, body: String, date: Date)
}

extension ContentEditable where Self: CommonViewModelLogic {
    func fetch(_ indexPath: Int) -> ProjectUnit? {
        data.value[indexPath]
    }

    func edit(
        indexPath: Int,
        title: String,
        body: String,
        date: Date
    ) {
        var data = data.value[indexPath]
        data.title = title
        data.body = body
        data.deadLine = date
        
        self.data.value[indexPath] = data
        do {
            try databaseManager.update(data: data)
        } catch {
            message = "Edit Error"
        }
    }
}
