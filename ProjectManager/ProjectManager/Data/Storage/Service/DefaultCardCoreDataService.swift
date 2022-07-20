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
  
  private let storage: CoreDataStorage
  
  init(storage: CoreDataStorage = .shared) {
    self.storage = storage
  }
  
  func create(card: Card) -> Observable<Never> {
    return Completable.create { [weak self] observer in
      guard let self = self else {
        observer(.error(CardCoreDataServiceError.invalidCardCoreData))
        return Disposables.create()
      }
      guard let entity = NSEntityDescription.entity(
        forEntityName: Settings.cardEntityName,
        in: self.storage.context) else {
        observer(.error(CardCoreDataServiceError.createCardEntityFailure))
        return Disposables.create()
      }
      
      let object = NSManagedObject(entity: entity, insertInto: self.storage.context)
      object.setValue(card.id, forKey: "id")
      object.setValue(card.title, forKey: "title")
      object.setValue(card.description, forKey: "body")
      object.setValue(card.deadlineDate, forKey: "deadlineDate")
      object.setValue(card.cardType.rawValue, forKey: "cardType")
      
      self.storage.saveContext()
      observer(.completed)
      
      return Disposables.create()
    }.asObservable()
  }
  
  func fetchOne(id: String) -> Observable<CardEntity> {
    return Single<CardEntity>.create { [weak self] observer in
      guard let self = self else {
        observer(.failure(CardCoreDataServiceError.invalidCardCoreData))
        return Disposables.create()
      }
      
      let request = CardEntity.fetchRequest()
      request.predicate = NSPredicate(format: "id = %@", id)
      
      if let object = try? self.storage.context.fetch(request).first {
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
      
      if let objects = try? self.storage.context.fetch(CardEntity.fetchRequest()) {
        observer(.success(objects))
        return Disposables.create()
      }
      observer(.failure(CardCoreDataServiceError.fetchAllFailure))
      return Disposables.create()
    }.asObservable()
  }
  
  func update(card: Card) -> Observable<Never> {
    return Completable.create { [weak self] observer in
      guard let self = self else {
        observer(.error(CardCoreDataServiceError.invalidCardCoreData))
        return Disposables.create()
      }
      
      let request = CardEntity.fetchRequest()
      request.predicate = NSPredicate(format: "id = %@", card.id)

      if let object = try? self.storage.context.fetch(request).first {
        object.setValue(card.title, forKey: "title")
        object.setValue(card.description, forKey: "body")
        object.setValue(card.deadlineDate, forKey: "deadlineDate")
        object.setValue(card.cardType.rawValue, forKey: "cardType")

        self.storage.saveContext()
        observer(.completed)
        return Disposables.create()
      }
      observer(.error(CardCoreDataServiceError.updateCardEntityFailure))
      return Disposables.create()
    }.asObservable()
  }

  func delete(id: String) -> Observable<Never> {
    return Completable.create { [weak self] observer in
      guard let self = self else {
        observer(.error(CardCoreDataServiceError.invalidCardCoreData))
        return Disposables.create()
      }
      
      let request = CardEntity.fetchRequest()
      request.predicate = NSPredicate(format: "id = %@", id)

      if let object = try? self.storage.context.fetch(request).first {
        self.storage.context.delete(object)
        self.storage.saveContext()
        observer(.completed)
        return Disposables.create()
      }
      observer(.error(CardCoreDataServiceError.deleteCardEntityFailure))
      return Disposables.create()
    }.asObservable()
  }
  
  func deleteAll() -> Observable<Never> {
    return Completable.create { [weak self] observer in
      guard let self = self else {
        observer(.error(CardCoreDataServiceError.invalidCardCoreData))
        return Disposables.create()
      }
      
      let deleteRequest = NSBatchDeleteRequest(fetchRequest: CardEntity.fetchRequest())
      
      do {
        try self.storage.context.execute(deleteRequest)
        observer(.completed)
      } catch {
        observer(.error(CardCoreDataServiceError.deleteAllFailure))
      }
      return Disposables.create()
    }.asObservable()
  }
  
  func count() -> Observable<Int> {
    return fetchAll().map { $0.count }
  }
}
