//
//  Project.swift
//  ProjectManager
//
//  Created by junho lee on 2023/01/13.
//

import Foundation

struct Project: Identifiable {
    let id: UUID
    var state: ProjectState
    var title: String
    var description: String
    var dueDate: Date

    init(id: UUID = UUID(), state: ProjectState = .todo, title: String, description: String, dueDate: Date) {
        self.id = id
        self.state = state
        self.title = title
        self.description = description
        self.dueDate = dueDate
    }
}

extension Project {
    static let sampleProjects = {
        var projects: [Project] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        projects.append(Project(state: .todo,
                                title: "책상정리",
                                description: "집중이 안될때 역시나 책상정리",
                                dueDate: Date()))
        projects.append(Project(state: .todo,
                                title: "라자냐 재료사러 가기",
                                description: "프로젝트 회고를 작성하면 내가 이번프로젝트에서 무엇을 놓쳤는 지 명확히 알 수 있어요.",
                                dueDate: dateFormatter.date(from: "2019/01/05")!))
        projects.append(Project(state: .todo,
                                title: "일기쓰기",
                                description: "난... ㄱㅏ끔...일ㄱㅣ를 쓴ㄷㅏ...",
                                dueDate: dateFormatter.date(from: "2021/03/06")!))
        projects.append(Project(state: .todo,
                                title: "설거지하기",
                                description: "밥을 먹었으면 응당 해야할 일",
                                dueDate: dateFormatter.date(from: "2020/12/05")!))
        projects.append(Project(state: .todo,
                                title: "빨래하기",
                                description: "그만 쌓아두고...\n근데...\n여전히 하기 싫다",
                                dueDate: dateFormatter.date(from: "2022/12/25")!))
        projects.append(Project(state: .doing,
                                title: "TIL 작성하기",
                                description: "TIL을 작성하면\n오늘의 상큼한 마무리도 되고\n 나중에 포트폴리오 용으로도 좋죠!",
                                dueDate: dateFormatter.date(from: "2021/11/05")!))
        projects.append(Project(state: .doing,
                                title: "프로젝트 회고 작성",
                                description: "프로젝트 회고를 작성하면 내가 이번프로젝트에서 무엇을 놓쳤는지 명확히 알 수 있어요.",
                                dueDate: dateFormatter.date(from: "2018/03/01")!))
        projects.append(Project(state: .done,
                                title: "오늘의 할일 찾기",
                                description: "내가 가는 이 길이 어디로 가는지 어디로 날 데려가는지 그 곳은 어딘 지 알 수 없지만 알 수 없지만 알 수 없지만 오늘도 난 걸어가고 있네 사람들은 길이 다 정해져 있는지 아니면 자기가 자신의 길을 만들어 가는지 알 수 없지만 알 수 없지만 알 수 없지만 이렇게 또 걸어가고 있네",
                                dueDate: dateFormatter.date(from: "2022/01/30")!))
        projects.append(Project(state: .done,
                                title: "프로젝트 회고 작성",
                                description: "노는 게 제일 좋아 친구들 모여라 언제나 즐거워 개구쟁이 뽀로로 눈 덮힌 숲속 마을 꼬마 펭귄 나가신다 언제나 즐거워 오늘은 또 무슨 일이 생길까 뽀로로를 불러봐요 뽀롱뽀로로 뽀롱뽀로로 뽀롱뽀롱뽀롱뽀롱뽀로로 노는 게 제일 좋아 친구들 모여라 언제나 즐거워 뽀롱뽀롱 뽀롱뽀롱 뽀로로1",
                                dueDate: dateFormatter.date(from: "2021/10/09")!))
        projects.append(Project(state: .done,
                                title: "방정리",
                                description: "눈 감고 그댈 그려요 맘 속 그댈 찾았죠 나를 밝혀주는 빛이 보여 영원한 행복을 놓칠 순 없죠 그대 나 보이나요 나를 불러줘요 그대 곁에 있을 거야 너를 사랑해 함께해요 그대와 영원히",
                                dueDate: dateFormatter.date(from: "2023/01/29")!))
        return projects
    }()
}
