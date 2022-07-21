//
//  RealtimeDatabaseServiceError.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/20.
//

enum RealtimeDatabaseServiceError: Error {
  case errorIsOccurred(Error?)
  case decodingFailure
  case writeToRealtimeDatabaseFailure
}
