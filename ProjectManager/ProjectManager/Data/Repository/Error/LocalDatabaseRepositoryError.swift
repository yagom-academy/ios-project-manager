//
//  LocalDatabaseRepositoryError.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/20.
//

enum LocalDatabaseRepositoryError: Error {
  case createCardEntityFailure
  case fetchCardEntityFailure
  case fetchAllFailure
  case updateCardEntityFailure
  case deleteCardEntityFailure
  case deleteAllFailure
  case invalidCardCoreData
}
