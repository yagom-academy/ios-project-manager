//
//  TaskCollectionViewController.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/24.
//

protocol TaskCollectionViewController {
    var mode: WorkState { get }
    var viewModel: any CollectionViewModel { get set }
}
