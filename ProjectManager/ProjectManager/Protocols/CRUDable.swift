//
//  CRUDable.swift
//  ProjectManager
//
//  Created by 노유빈 on 2023/01/17.
//

protocol CRUDable {
    associatedtype T

    func create(data: T)
    func read() -> [T]
    func update(data: T)
    func delete(data: T)
}
