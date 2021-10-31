//
//  Model.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/10/31.
//

import Foundation

protocol ViewModelAble {
    associatedtype Input
    associatedtype Output
    associatedtype Dependency
    
    var input: Input { get }
    var output: Output { get }
    var dependency: Dependency { get }
}

