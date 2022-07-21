//
//  DefaultRealtimeDatabaseService.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/20.
//

import Foundation

import FirebaseDatabase
import RxSwift

final class DefaultRealtimeDatabaseService: RealtimeDatabaseService {
  private let database: DatabaseReference
  
  init(database: DatabaseReference = Database.database().reference()) {
    self.database = database
  }
  
  func fetch() -> Observable<[Card]> {
    return Single.create { [weak self] observer in
      self?.database.getData { error, snapshot in
        guard error == nil else {
          observer(.failure(RealtimeDatabaseServiceError.errorIsOccurred(error)))
          return
        }
        
        guard let dic = snapshot?.value as? [String: Any],
              let data = try? JSONSerialization.data(withJSONObject: dic.map({ $1 })),
              let cards = try? JSONDecoder().decode([Card].self, from: data)
        else {
          observer(.failure(RealtimeDatabaseServiceError.decodingFailure))
          return
        }
        observer(.success(cards))
      }
      return Disposables.create()
    }.asObservable()
  }
  
  func write(cards: [Card]) -> Observable<Void> {
    return Single.create { [weak self] observer in
      var container = [String: Any]()

      for card in cards {
        if let data = try? JSONEncoder().encode(card),
           let encodedCard = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
          container[card.id] = encodedCard
        } else {
          observer(.failure(RealtimeDatabaseServiceError.writeToRealtimeDatabaseFailure))
          return Disposables.create()
        }
      }
      self?.database.setValue(container)
      observer(.success(()))
      
      return Disposables.create()
    }.asObservable()
  }
}
