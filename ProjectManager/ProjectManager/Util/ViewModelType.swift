//
//  ViewModelType.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/05.
//

protocol ViewModelType {
  associatedtype Input
  associatedtype Output
  
  func transform(input: Input) -> Output
}
