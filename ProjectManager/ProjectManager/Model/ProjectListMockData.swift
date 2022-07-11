//
//  ProjectListMockData.swift
//  ProjectManager
//
//  Created by Minseong on 2022/07/12.
//

import Foundation

struct ProjectListMockData {
  static let sample = [
    ProjectList(title: "책상정리", body: "집중이 안될땐 역시나 책상정리", date: Date(), projectCategory: .todo),
    ProjectList(title: "라자냐 재료사러 가기", body: "프로젝트 회고를 작성하면 내가 이번 프로젝트에서 무엇을 놓쳤는지 명확히 알 수 있어요.", date: Date(), projectCategory: .todo),
    ProjectList(title: "일기쓰기", body: "난... ㄱ ㅏ끔...일ㄱ ㅣ를 쓴ㄷ ㅏ...", date: Date(), projectCategory: .todo),
    ProjectList(title: "설거지하기", body: "밥을 먹었으면 응당 해야할 일", date: Date(), projectCategory: .todo),
    ProjectList(title: "빨래하기", body: "그만 쌓아두고...\n근데...\n여전히 하기 싫다", date: Date(), projectCategory: .todo),
    ProjectList(title: "TIL 작성하기", body: "TIL을 작성하면\n오늘의 상큼한 마무리도 되고\n 나중에 포트폴리오 용으로도 좋죠!", date: Date(), projectCategory: .doing),
    ProjectList(title: "프로젝트 회고 작성", body: "프로젝트 회고를 작성하면 내가 이번 프로젝트에서 무엇을 놓쳤는지 명확히 알 수 있어요.", date: Date(), projectCategory: .doing),
    ProjectList(title: "오늘의 할일 찾기", body: "내가 가는 이길이 어디로 가는지 어디로 날 데려가는지 그 곳은 어딘지 알 수 없지만 알 수 없지만 알 수 없지만 오늘도 난 걸어가고 있네 사람들은 길이 다 정해져 있네", date: Date(), projectCategory: .done),
    ProjectList(title: "회고 작성", body: "일 좋아 친구들 모여라 개구쟁이 뽀로로 꼬마 펭귄 나가신다", date: Date(), projectCategory: .done),
    ProjectList(title: "방 정리", body: "눈 감고 그댈 그려요 맘속 그댈 찾았죠 나를 밝혀주는 빛이 보여 영원한 행복을 놓칠 순 없죠 그대 나 보이네요 나를 불러줘요 그대 곁에 있을 거야 너를 사랑해 함께해요 하하하하하", date: Date(), projectCategory: .done)
  ]
}
