//
//  CardNotificationService.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/26.
//

protocol CardNotificationService {
  func registerCardNotification(_ card: Card)
  func registerCardsNotification(_ cards: [Card])
  func updateCardNotification(_ card: Card)
  func removeCardNotification(_ card: Card)
  func removeCardsNotification(_ cards: [Card])
  func removeAllCardNotification()
}
