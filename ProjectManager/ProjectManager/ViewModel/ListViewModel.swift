//
//  ListViewModel.swift
//  ProjectManager
//
//  Created by 무리 on 2023/05/19.
//

import Foundation

final class ListViewModel {
    var todoList: [ToDoModel] = [ToDoModel(title: "할 일 제목1", description: "할 일 내용1", deadLine: Date(), state: .Todo),
                                 ToDoModel(title: "할 일 제목2", description: "할 일 내용2", deadLine: Date(), state: .Todo),
                                 ToDoModel(title: "할 일 제목3", description: "할 일 내용3", deadLine: Date(), state: .Todo),
                                 ToDoModel(title: "할 일 제목4", description: "할 일 내용4", deadLine: Date(), state: .Todo),
                                 ToDoModel(title: "할 일 제목5", description: "할 일 내용5", deadLine: Date(), state: .Todo),
                                 ToDoModel(title: "한 일 제목1", description: "한 일 내용1", deadLine: Date(), state: .Done),
                                 ToDoModel(title: "한 일 제목2", description: "한 일 내용2", deadLine: Date(), state: .Done),
                                 ToDoModel(title: "한 일 제목3", description: "한 일 내용3", deadLine: Date(), state: .Done),
                                 ToDoModel(title: "한 일 제목4", description: "한 일 내용4", deadLine: Date(), state: .Done),
                                 ToDoModel(title: "하는 중 제목1", description: "하는 중 내용1", deadLine: Date(), state: .Doing),
                                 ToDoModel(title: "하는 중 제목2", description: "하는 중 내용2", deadLine: Date(), state: .Doing)]
    
    func configureCell(to cell: ListViewCell, with data: ToDoModel) {
        cell.configureContent(with: data)
    }
}
