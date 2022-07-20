//
//  CardCoreDataServiceError.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/20.
//

enum CardCoreDataServiceError: Error {
  case fetchEntityDescripitonFailure
  case invalidCardCoreData
  case fetchCardEntityFailure
  case fetchAllFailure
  case updateCardEntityFailure
  case deleteCardEntityFailure
  case deleteAllFailure
}
