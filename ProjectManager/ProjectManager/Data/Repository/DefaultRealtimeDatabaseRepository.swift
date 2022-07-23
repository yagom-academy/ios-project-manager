//
//  DefaultRealtimeDatabaseRepository.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/20.
//

import Foundation

import FirebaseDatabase
import RxSwift

protocol DatabaseReferable {
  func getData(completion block: @escaping (Error?, DataSnapshot?) -> Void)
  func setValue(_ value: Any?)
}

extension DatabaseReference: DatabaseReferable {}

final class DefaultRealtimeDatabaseRepository: RealtimeDatabaseRepository {
  private let database: DatabaseReferable
  
  init(database: DatabaseReferable = Database.database().reference()) {
    self.database = database
  }
  
  func fetchAll() -> Observable<[Card]> {
    return Single.create { [weak self] observer in
      self?.database.getData { error, snapshot in
        guard error == nil else {
          observer(.failure(RealtimeDatabaseRepositoryError.errorIsOccurred(error)))
          return
        }
        
        guard let value = snapshot?.value as? [String: Any],
              let data = try? JSONSerialization.data(withJSONObject: value.map { $1 }),
              let cards = try? JSONDecoder().decode([Card].self, from: data)
        else {
          observer(.failure(RealtimeDatabaseRepositoryError.decodingFailure))
          return
        }
        observer(.success(cards))
      }
      return Disposables.create()
    }.asObservable()
  }
  
  func create(_ cards: [Card]) -> Observable<[Card]> {
    return Single.create { [weak self] observer in
      var container = [String: Any]()

      for card in cards {
        if let data = try? JSONEncoder().encode(card),
           let encodedCard = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
          container[card.id] = encodedCard
        } else {
          observer(.failure(RealtimeDatabaseRepositoryError.writeToRealtimeDatabaseFailure))
          return Disposables.create()
        }
      }
      self?.database.setValue(container)
      observer(.success(cards))
      
      return Disposables.create()
    }.asObservable()
  }
}
