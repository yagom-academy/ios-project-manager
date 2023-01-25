//
//  ProcessViewModel.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/20.
//

import Foundation

final class ProcessViewModel {
    private(set) var process: Process
    
    private var datas: [Plan] = [] {
        didSet {
            datasHandler?(datas)
        }
    }

    private var datasHandler: (([Plan]) -> Void)?
    
    init(process: Process) {
        self.process = process
    }
}

// MARK: - Method
extension ProcessViewModel {
    func bindDatas(handler: @escaping ([Plan]) -> Void) {
        datasHandler = handler
    }
    
    func updateDatas(data: [Plan]) {
        datas = data
    }
}
