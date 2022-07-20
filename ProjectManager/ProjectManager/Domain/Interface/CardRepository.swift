//
//  CardRepository.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/19.
//

import RxSwift

protocol CardRepository {
  func createCard(_ card: Card) -> Observable<Never>
  func fetchCard(id: String) -> Observable<Card>
  func fetchCards() -> Observable<[Card]>
  func updateCard(_ card: Card) -> Observable<Never>
  func deleteCard(_ card: Card) -> Observable<Never>
}
