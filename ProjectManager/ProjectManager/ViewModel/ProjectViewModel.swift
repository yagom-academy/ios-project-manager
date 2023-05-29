//
//  ProjectViewModel.swift
//  ProjectManager
//
//  Created by kaki, 릴라 on 2023/05/23.
//

import Foundation

final class ProjectViewModel: ObservableObject {
    @Published private var projectList: [Project] = [Project(title: "오늘의 할일 찾기", body: "내가 가는 이길이 어디로 가는지 어디로 날 데려가는지 그곳은 어딘지 알 수 없지만 알 수 없지만 알 수 없지만 오늘도 난 걸어가고 있네 사람들은 길이 다 정해져 있다고 하지만", date: Date()), Project(title: "라자냐 재료사러 가기", body: "프로젝트 회고를 작성하면 내가 이번 프로젝트에서 무엇을 놓쳤는지 명확히 알 수 있어요.", date: Date()), Project(title: "책상정리", body: "집중이 안될땐 역시나 책상정리", date: Date()), Project(state: .done, title: "안녕", body: "하세요", date: Date() )]
    
    func search(state: ProjectState) -> [Project] {
        let list = projectList.filter { $0.state == state }
        
        return list
    }
    
    func create(project: Project) {
        projectList.append(project)
    }
    
    func update(project: Project) {
        guard let firstIndex = projectList.firstIndex(where: { $0.id == project.id }) else { return }
        
        projectList[firstIndex] = project
    }
    
    
    
    func delete(state: ProjectState, at indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        
        let list = search(state: state)
        guard let target = list[safe:index],
              let firstIndex = projectList.firstIndex(where: { $0.id == target.id }) else { return }
   
        projectList.remove(at: firstIndex)
    }
    
    func move(project: Project, to state: ProjectState) {
        guard let firstIndex = projectList.firstIndex(where: { $0.id == project.id }) else { return }
        
        let item = projectList.remove(at: firstIndex)
        item.state = state
        projectList.append(item)
    }
}
