//
//  DataSourceSection.swift
//  ProjectManager
//
//  Created by Finnn on 2022/09/17.
//

import RxDataSources

struct DataSourceSection {
    typealias Item = Todo
    
    var headerTitle: String
    var items: [Item]
    
    init(headerTitle: String, items: [Todo]) {
        self.headerTitle = headerTitle
        self.items = items
    }
}

extension DataSourceSection: AnimatableSectionModelType {
    var identity: String {
        return headerTitle
    }
    
    init(original: DataSourceSection, items: [Todo]) {
        self = original
        self.items = items
    }
}
