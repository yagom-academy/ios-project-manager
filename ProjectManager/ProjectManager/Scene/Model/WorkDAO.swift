//
//  WorkDAO.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/08.
//

import Foundation

struct WorkDAO: ProjectManagerDataProtocol {
    private var data = [WorkDTO]()
    
    mutating func append(work: WorkDTO) {
        data.append(work)
    }
                    
    func read() -> [WorkDTO] {
        return data
    }
    
    func read(workState: WorkState) -> [WorkDTO] {
        return data.filter { $0.workState == workState }
    }
    
    mutating func update(id: String, work: WorkDTO) {
        delete(id: id)
        data.append(work)
    }
    
    mutating func delete(id: String) {
        data = data.filter { $0.id != id }
    }
}
