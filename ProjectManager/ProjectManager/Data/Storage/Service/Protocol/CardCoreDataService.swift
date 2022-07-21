//
//  CardCoreDataService.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/20.
//

import RxSwift

protocol CardCoreDataService {
  func create(card: Card) -> Observable<Void>
  func create(cards: [Card]) -> Observable<[Card]>
  func fetchOne(id: String) -> Observable<CardEntity>
  func fetchAll() -> Observable<[CardEntity]>
  func update(card: Card) -> Observable<Void>
  func delete(id: String) -> Observable<Void>
  func deleteAll() -> Observable<Void>
  func count() -> Observable<Int>
}
