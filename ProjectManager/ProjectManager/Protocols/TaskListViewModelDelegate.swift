//
//  planListViewModelDelegate.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/26.
//

import Foundation

protocol planListViewModelDelegate {
    func createplan(_ plan: Plan)
    func updateplan(_ plan: Plan)
    func deleteplan(id: UUID)
}
