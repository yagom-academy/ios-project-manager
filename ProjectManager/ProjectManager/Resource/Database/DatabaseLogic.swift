//
//  DatabaseLogic.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/07.
//

import Foundation

protocol DatabaseLogic {
    func create(data: ProjectUnit) throws
    func fetchSection(_ section: String) throws -> [ProjectUnit]
    func update(data: ProjectUnit) throws
    func delete(id: UUID) throws
}
