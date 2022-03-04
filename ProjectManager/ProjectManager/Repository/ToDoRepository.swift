//
//  ToDoRepository.swift
//  ProjectManager
//
//  Created by 서녕 on 2022/03/04.
//

import Foundation

class ToDoRepository {
    var todos = [UUID: ToDoInfomation]()    //데이터베이스 역할(엔티티)
    
    func save(with todo: ToDoInfomation) {
        todos[todo.id] = todo
    }
    
    func delete(with todo: ToDoInfomation) {
        todos.removeValue(forKey: todo.id)
    }
    
    func update(with todo: ToDoInfomation) {
        todos.updateValue(todo, forKey: todo.id)
    }
    
    func fetch(onCompleted: @escaping ([ToDoInfomation]) -> Void) {
        todos = [UUID(): ToDoInfomation(id: UUID(), title: "산골짜기다람쥐아기다람쥐산골짜기다람쥐아기다람쥐산골짜기다람쥐아기다람쥐", discription: "도토리점심도토리묵도토리전도톨도톨도토리 한 줄이며, 길면 잘라서 마지막 부분을 …로 표시합니다설명이 세 줄 이상이면 세 줄 까지만 표시합니다설명이 세 줄 이하라면, 설명글의 높이에 맞게 셀의 높이가 맞춰집니다TODO와 DOING의 기한에 지난 날짜가 있으면 빨간색으로 표시합니다오른쪽 위의 + 버튼을 선택하면 새로운 할일을 추가하는 작성양식이 표시됩니다작성한 할일은 [할일(TODO)] 영역에 추가합니다할일을 터치하면 상세내", deadline: 343232345, position: .ToDo)]
        let todoData = todos.map { $0.value }
        onCompleted(todoData)
    }
    

}
