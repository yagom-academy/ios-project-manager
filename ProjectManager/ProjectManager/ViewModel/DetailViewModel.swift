//
//  DetailViewModel.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/14.
//

import Foundation

final class DetailViewModel {
    private var process: Process
    private var index: Int?
    private var detailData: Todo? {
        didSet {
            detailDataHandler?(detailData)
        }
    }
    
    private var detailDataHandler: ((Todo?) -> Void)?
    
    init(process: Process, index: Int?, data: Todo?) {
        self.process = process
        self.index = index
        self.detailData = data
    }
    
    func bindDetailData(handler: @escaping (Todo?) -> Void) {
        handler(detailData)
        self.detailDataHandler = handler
    }
    
    func fetchDataProcess() -> Process {
        return process
    }
    
    func fetchDataIndex() -> Int? {
        return index
    }
}
