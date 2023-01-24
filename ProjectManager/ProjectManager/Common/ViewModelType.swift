//
//  ViewModelType.swift
//  ProjectManager
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
