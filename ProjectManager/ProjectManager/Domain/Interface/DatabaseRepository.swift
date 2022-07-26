//
//  DatabaseRepository.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/24.
//

import RxSwift

protocol DatabaseRepository {
  func fetchAll() -> Observable<[Card]>
  func create(_ cards: [Card]) -> Observable<[Card]>
}
