//
//  HistoryRepositoryable.swift
//  ProjectManager
//
//  Created by Kim Do hyung on 2021/11/14.
//

import Foundation

protocol HistoryRepositoryable {
    func fetch(completion: @escaping (Result<[History], Error>) -> Void)
}
