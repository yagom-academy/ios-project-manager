//
//  ViewModel.swift
//  ProjectManager
//
//  Created by Max on 2023/09/24.
//

import Foundation

protocol ViewModelProtocol {
    associatedtype Entity
    associatedtype ViewModelError
    
    var entityList: Observable<[Entity]> { get set }
    var errorMessage: Observable<String?> { get set }
    var error: Observable<ViewModelError?> { get set }
    
    func fetchData()
    func createData(values: [KeywordArgument])
    func updateData(_ entity: Entity, values: [KeywordArgument])
    func deleteData(_ entity: Entity)
    func handle(error: Error)
    func setError(_ error: ViewModelError)
}
