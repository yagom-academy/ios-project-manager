//
//  planFetchDelegate.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/23.
//

protocol DetailViewModelDelegate: AnyObject {
    func create(plan: Plan)
    func update(plan: Plan)
    func setState(isUpdating: Bool)
}
