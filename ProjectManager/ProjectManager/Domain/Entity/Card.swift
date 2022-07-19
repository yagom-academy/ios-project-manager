//
//  Card.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/04.
//

import Foundation

struct Card: Equatable {
  private(set) var id = UUID().uuidString
  var title: String
  var description: String
  var deadlineDate: Date
  var cardType: CardType = .todo
}

enum CardType: Int16, CustomStringConvertible {
  case todo = 0
  case doing = 1
  case done = 2

  var description: String {
    switch self {
    case .todo: return "TODO"
    case .doing: return "DOING"
    case .done: return "DONE"
    }
  }
  
  var moveToMenuTitle: String {
    switch self {
    case .todo:
      return "MOVE TO TODO"
    case .doing:
      return "MOVE TO DOING"
    case .done:
      return "MOVE TO DONE"
    }
  }
  
  var distinguishMenuType: [CardType] {
    switch self {
    case .todo: return [.doing, .done]
    case .doing: return [.todo, .done]
    case .done: return [.todo, .doing]
    }
  }
}


#if DEBUG
extension Card {
  static let day: TimeInterval = 60 * 60 * 24
  static let sample = [
    Card(title: "책상정리", description: "집중이 안될땐 역시나 책상정리", deadlineDate: Date().advanced(by: day), cardType: .todo),
    Card(title: "라자냐 재료사러 가기", description: "프로젝트 회고를 작성하면 내가 이번 프로젝트에서 무엇을 놓쳤는지 명확히 알 수 있어요.", deadlineDate: Date().advanced(by: -day), cardType: .todo),
    Card(title: "일기쓰기", description: "난... ㄱ ㅏ끔...일ㄱ ㅣ를 쓴ㄷ ㅏ...", deadlineDate: Date().advanced(by: day), cardType: .todo),
    Card(title: "설거지하기", description: "밥을 먹었으면 응당 해야할 일", deadlineDate: Date(), cardType: .todo),
    Card(title: "빨래하기", description: "그만 쌓아두고...\n근데...\n여전히 하기 싫다", deadlineDate: Date(), cardType: .todo),
    Card(title: "TIL 작성하기", description: "TIL을 작성하면\n오늘의 상큼한 마무리도 되고\n 나중에 포트폴리오 용으로도 좋죠!", deadlineDate: Date().advanced(by: -day), cardType: .doing),
    Card(title: "프로젝트 회고 작성", description: "프로젝트 회고를 작성하면 내가 이번 프로젝트에서 무엇을 놓쳤는지 명확히 알 수 있어요.", deadlineDate: Date().advanced(by: -day), cardType: .doing),
    Card(title: "오늘의 할일 찾기", description: "내가 가는 이길이 어디로 가는지 어디로 날 데려가는지 그 곳은 어딘지 알 수 없지만 알 수 없지만 알 수 없지만 오늘도 난 걸어가고 있네 사람들은 길이 다 정해져 있네", deadlineDate: Date().advanced(by: day), cardType: .done),
    Card(title: "회고 작성", description: "일 좋아 친구들 모여라 개구쟁이 뽀로로 꼬마 펭귄 나가신다", deadlineDate: Date().advanced(by: -day), cardType: .done),
    Card(title: "방 정리", description: "눈 감고 그댈 그려요 맘속 그댈 찾았죠 나를 밝혀주는 빛이 보여 영원한 행복을 놓칠 순 없죠 그대 나 보이네요 나를 불러줘요 그대 곁에 있을 거야 너를 사랑해 함께해요 하하하하하", deadlineDate: Date().advanced(by: -day), cardType: .done),
  ]
}
#endif
