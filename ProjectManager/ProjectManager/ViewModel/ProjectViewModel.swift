//
//  ProjectViewModel.swift
//  ProjectManager
//
//  Created by kaki, 릴라 on 2023/05/23.
//

import Foundation

final class ProjectViewModel: ObservableObject {
    @Published var todoList: [Project] = [ Project(title: "오늘의 할일 찾기", body: "내가 가는 이길이 어디로 가는지 어디로 날 데려가는지 그곳은 어딘지 알 수 없지만 알 수 없지만 알 수 없지만 오늘도 난 걸어가고 있네 사람들은 길이 다 정해져 있다고 하지만", date: Date()), Project(title: "라자냐 재료사러 가기", body: "프로젝트 회고를 작성하면 내가 이번 프로젝트에서 무엇을 놓쳤는지 명확히 알 수 있어요.", date: Date()), Project(title: "책상정리", body: "집중이 안될땐 역시나 책상정리", date: Date())]
    @Published var doingList: [Project] = [Project(title: "오늘의 할일 찾기", body: "내가 가는 이길이 어디로 가는지 어디로 날 데려가는지 그곳은 어딘지 알 수 없지만 알 수 없지만 알 수 없지만 오늘도 난 걸어가고 있네 사람들은 길이 다 정해져 있다고 하지만", date: Date()), Project(title: "라자냐 재료사러 가기", body: "프로젝트 회고를 작성하면 내가 이번 프로젝트에서 무엇을 놓쳤는지 명확히 알 수 있어요.", date: Date()), Project(title: "책상정리", body: "집중이 안될땐 역시나 책상정리", date: Date())]
    @Published var doneList: [Project] = [Project(title: "오늘의 할일 찾기", body: "내가 가는 이길이 어디로 가는지 어디로 날 데려가는지 그곳은 어딘지 알 수 없지만 알 수 없지만 알 수 없지만 오늘도 난 걸어가고 있네 사람들은 길이 다 정해져 있다고 하지만", date: Date()), Project(title: "라자냐 재료사러 가기", body: "프로젝트 회고를 작성하면 내가 이번 프로젝트에서 무엇을 놓쳤는지 명확히 알 수 있어요.", date: Date()), Project(title: "책상정리", body: "집중이 안될땐 역시나 책상정리", date: Date())]
    
    @Published var projectList: [Project] = [Project(title: "오늘의 할일 찾기", body: "내가 가는 이길이 어디로 가는지 어디로 날 데려가는지 그곳은 어딘지 알 수 없지만 알 수 없지만 알 수 없지만 오늘도 난 걸어가고 있네 사람들은 길이 다 정해져 있다고 하지만", date: Date()), Project(title: "라자냐 재료사러 가기", body: "프로젝트 회고를 작성하면 내가 이번 프로젝트에서 무엇을 놓쳤는지 명확히 알 수 있어요.", date: Date()), Project(title: "책상정리", body: "집중이 안될땐 역시나 책상정리", date: Date()), Project(state: .done, title: "안녕", body: "하세요", date: Date() )]
    
    func createTodo() {
     
    }
    
    func selectList(cases: ProjectState) -> [Project] {
            switch cases {
            case .todo:
                return todoList
            case .doing:
                return doingList
            case .done:
                return doneList
            }
        }
    
    func search(state: ProjectState) -> [Project] {
        let list = projectList.filter { $0.state == state }
        
        return list
    }
    
//    func delete(cases: ProjectState, at indexSet: IndexSet) {
//        switch cases {
//        case .todo:
//            todoList.remove(atOffsets: indexSet)
//            print(todoList)
//        case .doing:
//            doingList.remove(atOffsets: indexSet)
//            print(doingList)
//        case .done:
//            doneList.remove(atOffsets: indexSet)
//            print(doneList)
//        }
//    }
    
    func delete(state: ProjectState, at indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        
        let list = search(state: state)
        let targetId = list[index].id
        
        guard let firstIndex = projectList.firstIndex(where: { $0.id == targetId }) else { return }
        
        projectList.remove(at: firstIndex)
    }
    
    func move(project: Project, state: ProjectState, to toState: ProjectState) {
        if(state == .todo && toState == .doing) {
            guard let firstIndex = todoList.firstIndex(where: { $0.id == project.id }) else { return }
            
            let item = todoList.remove(at: firstIndex)
            doingList.append(item)
            
            return
        }
        
        if(state == .todo && toState == .done) {
            guard let firstIndex = todoList.firstIndex(where: { $0.id == project.id }) else { return }
            
            let item = todoList.remove(at: firstIndex)
            doneList.append(item)
            
            return
        }
        
        if(state == .doing && toState == .todo) {
            guard let firstIndex = doingList.firstIndex(where: { $0.id == project.id }) else { return }
            
            let item = doingList.remove(at: firstIndex)
            todoList.append(item)
            
            return
        }
        
        if(state == .doing && toState == .done) {
            guard let firstIndex = doingList.firstIndex(where: { $0.id == project.id }) else { return }
            
            let item = doingList.remove(at: firstIndex)
            doneList.append(item)
            
            return
        }
        
        if(state == .done && toState == .todo) {
            guard let firstIndex = doneList.firstIndex(where: { $0.id == project.id }) else { return }
            
            let item = doneList.remove(at: firstIndex)
            todoList.append(item)
            
            return
        }
        
        if(state == .done && toState == .doing) {
            guard let firstIndex = doneList.firstIndex(where: { $0.id == project.id }) else { return }
            
            let item = doneList.remove(at: firstIndex)
            doingList.append(item)
            
            return
        }
    }
}
