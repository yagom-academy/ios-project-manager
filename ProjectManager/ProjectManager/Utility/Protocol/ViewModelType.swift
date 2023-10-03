//
//  ViewModel.swift
//  ProjectManager
//
//  Created by Max on 2023/09/24.
//

import Foundation

protocol ViewModelType {
    associatedtype ViewModelError
    
    var error: Observable<ViewModelError?> { get set }

    func handle(error: Error)
    func setError(_ error: ViewModelError)
}
