//
//  HistoryStorageable.swift
//  ProjectManager
//
//  Created by JINHONG AN on 2021/11/14.
//

import Foundation

protocol HistoryStorageable {
    func fetch(completion: @escaping(Result<[History], Error>) -> Void)
    func fetchLast(completion: @escaping(Result<History?, Error>) -> Void)
}
