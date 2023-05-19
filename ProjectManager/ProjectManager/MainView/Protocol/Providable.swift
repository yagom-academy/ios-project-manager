//
//  Providable.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/19.
//

protocol Providable {
    associatedtype ProvidedItem: Hashable
    func provide(_ item: ProvidedItem)
}
