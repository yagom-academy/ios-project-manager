//
//  OutputPort.swift
//  ProjectManager
//
//  Created by Gundy on 2023/01/14.
//

protocol OutputPort {
    func configurePlanList(toDo: [Plan], doing: [Plan], done: [Plan])
}
