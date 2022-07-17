//
//  EditViewModel.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/15.
//

import Foundation

final class EditViewModel: NSObject {
  private let storage: StorageType
  private let item: Todo
  
  init(storage: StorageType = MemoryStorage.shared, item: Todo) {
    self.storage = storage
    self.item = item
  }
}
