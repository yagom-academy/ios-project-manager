//
//  CoreDataStorageError.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/20.
//

enum CoreDataStorageError: Error, CustomStringConvertible {
  case loadPersistentStoreFailure
  case saveContextFailure(Error)
  
  var description: String {
    switch self {
    case .loadPersistentStoreFailure:
      return "영구 저장소를 불러오는데 실패했습니다."
    case .saveContextFailure(let error):
      return "영구 저장소에 저장하는데 실패했습니다. \(error)"
    }
  }
}
