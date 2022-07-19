//
//  CardRepository.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/19.
//

protocol CardRepository {
  func createCard(_ card: Card)
  func fetchCard(id: String) -> Card?
  func fetchCards() -> [Card]
  func updateCard(_ card: Card)
  func deleteCard(_ card: Card)
}
