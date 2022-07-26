//
//  FirebaseDatabaseService.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/25.
//

import Foundation

import FirebaseDatabase

protocol FirebaseDatabaseService {
  func getData(completion block: @escaping (Error?, DataSnapshot?) -> Void)
  func setValue(_ value: Any?)
}

extension DatabaseReference: FirebaseDatabaseService {}
