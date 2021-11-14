//
//  HistoryUseCase.swift
//  ProjectManager
//
//  Created by JINHONG AN on 2021/11/14.
//

import Foundation

protocol HistoryUseCaseable {
    func fetch(completion: @escaping (Result<[History], Error>) -> Void)
}

struct HistoryUseCase: HistoryUseCaseable {
    func fetch(completion: @escaping (Result<[History], Error>) -> Void) {
        
    }
}
