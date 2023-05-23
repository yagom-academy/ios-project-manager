//
//  ContentViewModel.swift
//  ProjectManager
//
//  Created by kaki, 릴라 on 2023/05/23.
//

import Foundation

class TodoViewModel: ObservableObject {
    @Published var todoList: [Todo] = [Todo(title: "오늘의 할일 찾기", body: "내가 가는 이길이 어디로 가는지 어디로 날 데려가는지 그곳은 어딘지 알 수 없지만 알 수 없지만 알 수 없지만 오늘도 난 걸어가고 있네 사람들은 길이 다 정해져 있다고 하지만", date: "2019. 1. 5."), Todo(title: "라자냐 재료사러 가기", body: "프로젝트 회고를 작성하면 내가 이번 프로젝트에서 무엇을 놓쳤는지 명확히 알 수 있어요.", date: "2019. 1. 5."), Todo(title: "책상정리", body: "집중이 안될땐 역시나 책상정리", date: "2019. 1. 5.")]
    @Published var doingList: [Todo] = [Todo(title: "오늘의 할일 찾기", body: "내가 가는 이길이 어디로 가는지 어디로 날 데려가는지 그곳은 어딘지 알 수 없지만 알 수 없지만 알 수 없지만 오늘도 난 걸어가고 있네 사람들은 길이 다 정해져 있다고 하지만", date: "2019. 1. 5."), Todo(title: "라자냐 재료사러 가기", body: "프로젝트 회고를 작성하면 내가 이번 프로젝트에서 무엇을 놓쳤는지 명확히 알 수 있어요.", date: "2019. 1. 5."), Todo(title: "책상정리", body: "집중이 안될땐 역시나 책상정리", date: "2019. 1. 5.")]
    @Published var doneList: [Todo] = [Todo(title: "오늘의 할일 찾기", body: "내가 가는 이길이 어디로 가는지 어디로 날 데려가는지 그곳은 어딘지 알 수 없지만 알 수 없지만 알 수 없지만 오늘도 난 걸어가고 있네 사람들은 길이 다 정해져 있다고 하지만", date: "2019. 1. 5."), Todo(title: "라자냐 재료사러 가기", body: "프로젝트 회고를 작성하면 내가 이번 프로젝트에서 무엇을 놓쳤는지 명확히 알 수 있어요.", date: "2019. 1. 5."), Todo(title: "책상정리", body: "집중이 안될땐 역시나 책상정리", date: "2019. 1. 5.")]
}
