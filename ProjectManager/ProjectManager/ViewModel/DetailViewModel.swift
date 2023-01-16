//
//  DetailViewModel.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/14.
//

import Foundation

final class DetailViewModel {
    private let process: Process

    private var detailData: Todo? {
        didSet {
            detailDataHandler?(detailData)
        }
    }
    
    private var detailDataHandler: ((Todo?) -> Void)?
    
    init(process: Process, data: Todo?) {
        self.process = process
        self.detailData = data
    }
    
    func bindDetailData(handler: @escaping (Todo?) -> Void) {
        handler(detailData)
        self.detailDataHandler = handler
    }
    
    func fetchProcess() -> Process {
        return process
    }
    
    func createData(title: String, content: String?, date: Date?) -> Todo {
        return Todo(title: title, content: content, deadLine: date)
    }
}
