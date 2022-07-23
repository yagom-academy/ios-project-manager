//
//  NetworkService.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/20.
//

import Foundation

import RxSwift

protocol NetworkService {
  func request(endpoint: Endpoint) -> Observable<Data>
}
