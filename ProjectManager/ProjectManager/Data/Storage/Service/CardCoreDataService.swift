//
//  CardCoreDataService.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/20.
//

import RxSwift

protocol CardCoreDataService {
  func create(card: Card) -> Observable<Never>
  func fetchOne(id: String) -> Observable<CardEntity>
  func fetchAll() -> Observable<[CardEntity]>
  func update(card: Card) -> Observable<Never>
  func delete(id: String) -> Observable<Never>
  func deleteAll() -> Observable<Never>
  func count() -> Observable<Int>
}
