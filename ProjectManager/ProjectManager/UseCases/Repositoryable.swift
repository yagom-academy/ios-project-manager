//
//  Repositoryable.swift
//  ProjectManager
//
//  Created by JINHONG AN on 2021/11/11.
//

import Foundation

protocol Repositoryable {
    func add(memo: Memo, completion: @escaping (Result<Memo, Error>) -> Void)
    func delete(memo: Memo, completion: @escaping (Result<Memo, Error>) -> Void)
    func update(memo: Memo, completion: @escaping (Result<Memo, Error>) -> Void)
    func fetch(completion: @escaping (Result<[Memo], Error>) -> Void)
}
