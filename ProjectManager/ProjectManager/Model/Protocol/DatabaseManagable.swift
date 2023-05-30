//
//  DatabaseManagable.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/30.
//

protocol DatabaseManagable {
    func create(object: Storable)
    func fetch(_ completion: @escaping (Result<[Storable], Error>) -> Void)
    func delete(object: Storable)
    func update(object: Storable)
}
