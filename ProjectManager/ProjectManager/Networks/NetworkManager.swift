//
//  NetworkManager.swift
//  ProjectManager
//
//  Created by 최정민 on 2021/07/19.
//

import Foundation

struct NetworkManager {
    private let baseURL = "".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    
    func get(completion: @escaping ([Task]) -> ()) {
        completion([])
    }
    
    func post(completion: @escaping (Task) -> ()) {
//        completion()
    }
    
    func patch(completion: @escaping () -> ()) {
        completion()
    }
    
    func delete(completion: @escaping () -> ()) {
        completion()
    }
}
