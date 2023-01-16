//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by Hamo, Wonbi on 2023/01/16.
//

import Foundation

protocol MainViewModelProtocol {
    var models: [Projectable] { get set }
    
    func createProject()
    func updateProject()
    func deleteProject()
}

final class MainViewModel: MainViewModelProtocol {
    
    var models: [Projectable] = []
    
    func createProject() {
        //
    }
    
    func updateProject() {
        //
    }
    
    func deleteProject() {
        //
    }
}
