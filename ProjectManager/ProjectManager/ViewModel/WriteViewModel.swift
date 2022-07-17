//
//  WriteViewModel.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/17.
//

import Foundation

final class WriteViewModel {
  private let storage: StorageType
  
  init(storage: StorageType = MemoryStorage.shared) {
    self.storage = storage
  }
}
