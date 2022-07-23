//
//  LocalDatabaseRepository.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/19.
//

import RxSwift

protocol LocalDatabaseRepository: DatabaseRepository {
  func create(_ card: Card) -> Observable<Void>
  func fetchOne(id: String) -> Observable<Card>
  func update(_ card: Card) -> Observable<Void>
  func delete(_ card: Card) -> Observable<Void>
  func deleteAll() -> Observable<Void>
  func count() -> Observable<Int>
}
