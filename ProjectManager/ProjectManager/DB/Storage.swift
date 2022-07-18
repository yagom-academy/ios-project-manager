//
//  Storage.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/17.
//

import Foundation
import Combine

protocol StorageType {
  func create(_ todo: Todo)
  func read() -> AnyPublisher<[Todo], Never>
  func update(_ todo: Todo)
  func delete(_ todo: Todo)
}
