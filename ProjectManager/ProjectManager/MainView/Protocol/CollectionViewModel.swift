//
//  CollectionViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/24.
//

protocol CollectionViewModel: AnyObject {
    var items: [Task] { get set }
}
