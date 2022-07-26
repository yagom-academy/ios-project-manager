//
//  NetworkServiceError.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/20.
//

enum NetworkServiceError: Error {
  case createURLRequestFailure
  case errorIsOccurred(Error?)
  case badRequest
  case unauthorized
  case notFound
  case internalServerError
  case serviceUnavailable
  case invalidateResponse
  case unknown
}
