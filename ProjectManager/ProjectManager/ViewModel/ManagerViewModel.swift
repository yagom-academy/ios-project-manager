//
//  ProjectManager.swift
//  ProjectManager
//
//  Created by 홍정아 on 2021/11/02.
//

import SwiftUI

let dummyProjects = [
    Project(id: UUID(),
            title: "책상정리",
            content: "집중이 안될땐 역시나 책상정리",
            dueDate: Date(),
            created: Date(timeIntervalSince1970: 1649651333),
            status: .todo),
    Project(id: UUID(),
            title: "라자냐 재료사러 가기",
            content: "프로젝트 회고를 작성하면 내가 이번 프로젝트에서 무엇을 놓쳤는지 명확히 알 수 있어요.",
            dueDate: Date(timeIntervalSince1970: 1564223600),
            created: Date(timeIntervalSince1970: 1538651333),
            status: .todo),
    Project(id: UUID(),
            title: "일기쓰기",
            content: "난...ㄱㅏ끔...일ㄱㅣ를 쓴ㄷㅏ...",
            dueDate: Date(timeIntervalSince1970: 1608651333),
            created: Date(timeIntervalSince1970: 1588651333),
            status: .todo),
    Project(id: UUID(),
            title: "설거지하기",
            content: "밥을 먹었으면 응당 해야할 일",
            dueDate: Date(timeIntervalSince1970: 1624223600),
            created: Date(timeIntervalSince1970: 1574223600),
            status: .todo),
    Project(id: UUID(),
            title: "빨래하기",
            content: "그만 쌓아두고...\n근데...\n여전히 하기 싫다",
            dueDate: Date(timeIntervalSince1970: 1694223600),
            created: Date(timeIntervalSince1970: 1554223600),
            status: .todo),
    Project(id: UUID(),
            title: "TIL 작성하기",
            content: "TIL을 작성하면\n오늘의 상큼한 마무리도 되고\n나중에 포트폴리오 용으로도 좋죠!",
            dueDate: Date(timeIntervalSince1970: 1564223600),
            created: Date(timeIntervalSince1970: 1539651333),
            status: .doing),
    Project(id: UUID(),
            title: "프로젝트 회고 작성",
            content: "프로젝트 회고를 작성하면 내가 이번 프로젝트에서\n무엇을 놓쳤는지 명확히 알 수 있어요.",
            dueDate: Date(timeIntervalSince1970: 1654223600),
            created: Date(timeIntervalSince1970: 1569651333),
            status: .doing),
    Project(id: UUID(),
            title: "오늘의 할일 찾기",
            content: "내가 가는 이길이 어디로 가는지 어디로 날 데려가는지",
            dueDate: Date(timeIntervalSince1970: 1629651333),
            created: Date(timeIntervalSince1970: 1619651333),
            status: .done),
    Project(id: UUID(),
            title: "프로젝트 회고 작성",
            content: "노는게 제일 좋아 친구들모여라\n언제나 즐거워 개구쟁이 뽀로로\n눈 덮인 숲속 마을 꼬마 펭귄 나가신다",
            dueDate: Date(timeIntervalSince1970: 1769651333),
            created: Date(timeIntervalSince1970: 1569651333),
            status: .done),
    Project(id: UUID(),
            title: "방정리",
            content: "눈감고 그댈 그려요 맘속 그댈 찾았죠",
            dueDate: Date(timeIntervalSince1970: 1539651333),
            created: Date(timeIntervalSince1970: 1519651333),
            status: .done)
]

class ManagerViewModel: ObservableObject {
    @Published private(set) var projects: [Project]
    @Published var addTapped: Bool
    
    init(projects: [Project] = dummyProjects, addTapped: Bool = false) {
        self.projects = projects
        self.addTapped = addTapped
    }
    
    func listViewModel(of status: Project.Status) -> ListViewModel {
        let projects = projects.filter { $0.status == status }
        return ListViewModel(managerViewModel: self, projects: projects, status: status)
    }
    
    func popupOptions(of projectID: UUID) -> [Project.Status] {
        return project(with: projectID).status.theOthers
    }
}

extension ManagerViewModel {
    func add(_ project: Project) {
        projects.insert(project, at: .zero)
    }
    
    func project(with projectID: UUID) -> Project {
        for project in projects {
            if project.id == projectID {
                return project
            }
        }
        return Project()
    }
    
    func update(_ newStatus: Project.Status, of projectID: UUID) {
        for index in projects.indices {
            if projects[index].id == projectID {
                projects[index].update(newStatus)
                return
            }
        }
    }
    
    func update(_ newProject: Project, with projectID: UUID) {
        for index in projects.indices {
            if projects[index].id == projectID {
                projects[index] = newProject
                return
            }
        }
    }
    
    func delete(_ status: Project.Status, at index: Int?) {
        guard let index = index else { return }
        let projectID = projects.filter({ $0.status == status })[index].id
        
        for index in projects.indices {
            if projects[index].id == projectID {
                projects.remove(at: index)
                return
            }
        }
    }
}
