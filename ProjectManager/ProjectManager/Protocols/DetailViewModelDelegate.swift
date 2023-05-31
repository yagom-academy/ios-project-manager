//
//  planFetchDelegate.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/23.
//

protocol DetailViewModelDelegate: AnyObject {
    func createplan(_ plan: Plan)
    func updateplan(_ plan: Plan)
    func setState(isUpdating: Bool)
}
