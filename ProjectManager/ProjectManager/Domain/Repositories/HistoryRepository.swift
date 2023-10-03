//
//  HistoryRepository.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/04.
//

import Foundation

protocol HistoryRepository {
    func fetchAll() -> [History]
    func save(_ history: History)
}
