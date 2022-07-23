//
//  DefaultCardCoreDataService.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/19.
//

import CoreData

import RxSwift

final class DefaultCardCoreDataService: CardCoreDataService {
  private enum Settings {
    static let cardEntityName = "CardEntity"
  }
  
  private let storage: CoreDataStoragable
  
  init(storage: CoreDataStoragable) {
    self.storage = storage
  }
  
  func create(card: Card) -> Observable<Void> {
    return Single.create { [weak self] observer in
      guard let self = self else {
        observer(.failure(CardCoreDataServiceError.invalidCardCoreData))
        return Disposables.create()
      }
      
      guard let object = self.storage.createObject(for: Settings.cardEntityName) as? CardEntity else {
        observer(.failure(CardCoreDataServiceError.createCardEntityFailure))
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
        observer(.failure(CardCoreDataServiceError.createCardEntityFailure))
      }
      
      return Disposables.create()
    }.asObservable()
  }
  
  func create(cards: [Card]) -> Observable<[Card]> {
    return Single.create { [weak self] observer in
      guard let self = self else {
        observer(.failure(CardCoreDataServiceError.invalidCardCoreData))
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
        observer(.failure(CardCoreDataServiceError.invalidCardCoreData))
      }
      
      return Disposables.create()
    }.asObservable()
  }
  
  func fetchOne(id: String) -> Observable<CardEntity> {
    return Single<CardEntity>.create { [weak self] observer in
      guard let self = self else {
        observer(.failure(CardCoreDataServiceError.invalidCardCoreData))
        return Disposables.create()
      }
      
      if let object = self.storage.fetchObject(for: Settings.cardEntityName, id: id) as? CardEntity {
        observer(.success(object))
        return Disposables.create()
      }
      observer(.failure(CardCoreDataServiceError.fetchCardEntityFailure))
      
      return Disposables.create()
    }.asObservable()
  }
  
  func fetchAll() -> Observable<[CardEntity]> {
    return Single<[CardEntity]>.create { [weak self] observer in
      guard let self = self else {
        observer(.failure(CardCoreDataServiceError.invalidCardCoreData))
        return Disposables.create()
      }
      
      if let objects = self.storage.fetchObjects(for: Settings.cardEntityName) as? [CardEntity] {
        observer(.success(objects))
        return Disposables.create()
      }
      observer(.failure(CardCoreDataServiceError.fetchAllFailure))
      
      return Disposables.create()
    }.asObservable()
  }
  
  func update(card: Card) -> Observable<Void> {
    return Single.create { [weak self] observer in
      guard let self = self else {
        observer(.failure(CardCoreDataServiceError.invalidCardCoreData))
        return Disposables.create()
      }
      
      guard let object = self.storage.fetchObject(for: Settings.cardEntityName, id: card.id) as? CardEntity else {
        observer(.failure(CardCoreDataServiceError.updateCardEntityFailure))
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
        observer(.failure(CardCoreDataServiceError.updateCardEntityFailure))
      }
      
      return Disposables.create()
    }.asObservable()
  }

  func delete(id: String) -> Observable<Void> {
    return Single.create { [weak self] observer in
      guard let self = self else {
        observer(.failure(CardCoreDataServiceError.invalidCardCoreData))
        return Disposables.create()
      }
      
      if self.storage.deleteObjectWithSave(for: Settings.cardEntityName, id: id) {
        observer(.success(()))
      } else {
        observer(.failure(CardCoreDataServiceError.deleteCardEntityFailure))
      }
      
      return Disposables.create()
    }.asObservable()
  }
  
  func deleteAll() -> Observable<Void> {
    return Single.create { [weak self] observer in
      guard let self = self else {
        observer(.failure(CardCoreDataServiceError.invalidCardCoreData))
        return Disposables.create()
      }
      
      if self.storage.deleteObjects(for: Settings.cardEntityName) {
        observer(.success(()))
      } else {
        observer(.failure(CardCoreDataServiceError.deleteAllFailure))
      }
      return Disposables.create()
    }.asObservable()
  }
  
  func count() -> Observable<Int> {
    return fetchAll().map { $0.count }
  }
}
