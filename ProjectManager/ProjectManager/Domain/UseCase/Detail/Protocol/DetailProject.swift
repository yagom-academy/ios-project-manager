//
//  DetailProject.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/19.
//

protocol DetailProject {
    
    var delegate: DetailProjectDelegate? { get set }
}

protocol DetailProjectDelegate: AnyObject {
    
    var viewModel: ListViewModel? { get set }
    func detailProject(willSave project: Project)
}
