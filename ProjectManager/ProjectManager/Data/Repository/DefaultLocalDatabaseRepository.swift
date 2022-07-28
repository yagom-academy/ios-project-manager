//
//  DefaultLocalDatabaseRepository.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/19.
//

import CoreData

import RxSwift

final class DefaultLocalDatabaseRepository: LocalDatabaseRepository {
  private enum Settings {
    static let cardEntityName = "CardEntity"
  }
  
  private let storage: CoreDataStoragable
  
  init(storage: CoreDataStoragable) {
    self.storage = storage
  }
  
  func create(_ card: Card) -> Observable<Void> {
    return Single.create { [weak self] observer in
      guard let self = self else {
        observer(.failure(LocalDatabaseRepositoryError.invalidCardCoreData))
        return Disposables.create()
      }
      
      guard let object = self.storage.createObject(for: Settings.cardEntityName) as? CardEntity else {
        observer(.failure(LocalDatabaseRepositoryError.createCardEntityFailure))
        return Disposables.create()
      }
      
      object.id = card.id
      object.title = card.title
      object.body = card.description
      object.deadlineDate = card.deadlineDate
      object.cardType = card.cardType.rawValue
      
      if self.storage.saveContext() {
        observer(.success(()))
      } else {
        observer(.failure(LocalDatabaseRepositoryError.createCardEntityFailure))
      }
      
      return Disposables.create()
    }.asObservable()
  }
  
  func create(_ cards: [Card]) -> Observable<[Card]> {
    return Single.create { [weak self] observer in
      guard let self = self else {
        observer(.failure(LocalDatabaseRepositoryError.invalidCardCoreData))
        return Disposables.create()
      }
      
      cards.forEach { card in
        guard let object = self.storage.createObject(for: Settings.cardEntityName) as? CardEntity else { return }
        
        object.id = card.id
        object.title = card.title
        object.body = card.description
        object.deadlineDate = card.deadlineDate
        object.cardType = card.cardType.rawValue
      }
      
      if self.storage.saveContext() {
        observer(.success(cards))
      } else {
        observer(.failure(LocalDatabaseRepositoryError.invalidCardCoreData))
      }
      
      return Disposables.create()
    }.asObservable()
  }
  
  func fetchOne(id: String) -> Observable<Card> {
    return Single<Card>.create { [weak self] observer in
      guard let self = self else {
        observer(.failure(LocalDatabaseRepositoryError.invalidCardCoreData))
        return Disposables.create()
      }
      
      if let object = self.storage.fetchObject(for: Settings.cardEntityName, id: id) as? CardEntity {
        observer(.success(object.toDomain()))
        return Disposables.create()
      }
      observer(.failure(LocalDatabaseRepositoryError.fetchCardEntityFailure))
      
      return Disposables.create()
    }.asObservable()
  }
  
  func fetchAll() -> Observable<[Card]> {
    return Single<[Card]>.create { [weak self] observer in
      guard let self = self else {
        observer(.failure(LocalDatabaseRepositoryError.invalidCardCoreData))
        return Disposables.create()
      }
      
      if let objects = self.storage.fetchObjects(for: Settings.cardEntityName) as? [CardEntity] {
        observer(.success(objects.map { $0.toDomain() }))
        return Disposables.create()
      }
      observer(.failure(LocalDatabaseRepositoryError.fetchAllFailure))
      
      return Disposables.create()
    }.asObservable()
  }
  
  func update(_ card: Card) -> Observable<Void> {
    return Single.create { [weak self] observer in
      guard let self = self else {
        observer(.failure(LocalDatabaseRepositoryError.invalidCardCoreData))
        return Disposables.create()
      }
      
      guard let object = self.storage.fetchObject(for: Settings.cardEntityName, id: card.id) as? CardEntity else {
        observer(.failure(LocalDatabaseRepositoryError.updateCardEntityFailure))
        return Disposables.create()
      }
      
      object.id = card.id
      object.title = card.title
      object.body = card.description
      object.deadlineDate = card.deadlineDate
      object.cardType = card.cardType.rawValue

      if self.storage.saveContext() {
        observer(.success(()))
      } else {
        observer(.failure(LocalDatabaseRepositoryError.updateCardEntityFailure))
      }
      
      return Disposables.create()
    }.asObservable()
  }

  func delete(_ card: Card) -> Observable<Void> {
    return Single.create { [weak self] observer in
      guard let self = self else {
        observer(.failure(LocalDatabaseRepositoryError.invalidCardCoreData))
        return Disposables.create()
      }
      
      if self.storage.deleteObjectWithSave(for: Settings.cardEntityName, id: card.id) {
        observer(.success(()))
      } else {
        observer(.failure(LocalDatabaseRepositoryError.deleteCardEntityFailure))
      }
      
      return Disposables.create()
    }.asObservable()
  }
  
  func deleteAll() -> Observable<Void> {
    return Single.create { [weak self] observer in
      guard let self = self else {
        observer(.failure(LocalDatabaseRepositoryError.invalidCardCoreData))
        return Disposables.create()
      }
      
      if self.storage.deleteObjects(for: Settings.cardEntityName) {
        observer(.success(()))
      } else {
        observer(.failure(LocalDatabaseRepositoryError.deleteAllFailure))
      }
      return Disposables.create()
    }.asObservable()
  }
  
  func count() -> Observable<Int> {
    return fetchAll().map { $0.count }
  }
  
  func isExist(id: String) -> Observable<Bool> {
    return fetchOne(id: id)
      .materialize()
      .flatMap { event -> Observable<Event<Bool>> in
        switch event {
        case .next(_): return .just(.next(true))
        case .error(_): return .just(.next(false))
        default: return .empty()
        }
      }
      .dematerialize()
  }
}
