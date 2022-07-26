//
//  DefaultNetworkService.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/20.
//

import Foundation

import RxSwift

final class DefaultNetworkService: NetworkService {
  private let urlSession: URLSession
  
  init(urlSession: URLSession) {
    self.urlSession = urlSession
  }
  
  func request(endpoint: Endpoint) -> Observable<Data> {
    return Single<Data>.create { [weak self] observer in
      guard let urlRequest = try? endpoint.create() else {
        observer(.failure(NetworkServiceError.createURLRequestFailure))
        return Disposables.create()
      }
      
      let task = self?.urlSession.dataTask(with: urlRequest) { data, response, error in
        guard error == nil, let data = data else {
          observer(.failure(NetworkServiceError.errorIsOccurred(error)))
          return
        }
        guard let response = response as? HTTPURLResponse else {
          observer(.failure(NetworkServiceError.invalidateResponse))
          return
        }
        
        switch response.statusCode {
        case 200..<300: observer(.success(data))
        case 400: observer(.failure(NetworkServiceError.badRequest))
        case 401: observer(.failure(NetworkServiceError.unauthorized))
        case 404: observer(.failure(NetworkServiceError.notFound))
        case 500: observer(.failure(NetworkServiceError.internalServerError))
        case 503: observer(.failure(NetworkServiceError.serviceUnavailable))
        default: observer(.failure(NetworkServiceError.unknown))
        }
      }
      task?.resume()
      
      return Disposables.create {
        task?.suspend()
        task?.cancel()
      }
    }.asObservable()
  }
}
