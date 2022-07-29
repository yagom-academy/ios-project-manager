//
//  DefaultCardNotificationService.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/26.
//

import UserNotifications

final class DefaultCardNotificationService: CardNotificationService {
  private enum Settings {
    static let contentTitle = "프로젝트 매니저 앱"
    static let contentSubTitle = "오늘 마감되는 카드가 있습니다."
    static let notificationHour = 9
  }
  
  private let userNotificationCenter: UserNotificationCenterable
  
  init(userNotificationCenter: UserNotificationCenterable) {
    self.userNotificationCenter = userNotificationCenter
    requestAuthorization()
  }
  
  private func requestAuthorization() {
    let options = UNAuthorizationOptions(arrayLiteral: .alert)
    userNotificationCenter.requestAuthorization(options: options) { _, error in }
  }
  
  func registerCardNotification(_ card: Card) {
    guard card.cardType != .done else { return }
    
    let request = createUserNotificationRequest(card: card)
    userNotificationCenter.add(request) { _ in }
  }
  
  func registerCardsNotification(_ cards: [Card]) {
    for card in cards where card.cardType != .done {
      registerCardNotification(card)
    }
  }
  
  func removeCardNotification(_ card: Card) {
    userNotificationCenter.removePendingNotificationRequests(withIdentifiers: [card.id])
  }
  
  func removeCardsNotification(_ cards: [Card]) {
    userNotificationCenter.removePendingNotificationRequests(withIdentifiers: cards.map { $0.id })
  }
  
  func removeAllCardNotification() {
    userNotificationCenter.removeAllPendingNotificationRequests()
  }
  
  private func createUserNotificationRequest(card: Card) -> UNNotificationRequest {
    let content = UNMutableNotificationContent()
    content.title = Settings.contentTitle
    content.subtitle = Settings.contentSubTitle
    content.body = card.title
    
    var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: card.deadlineDate)
    dateComponents.hour = Settings.notificationHour
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
    let request = UNNotificationRequest(identifier: card.id, content: content, trigger: trigger)
    return request
  }
}
