//
//  ListViewModel.swift
//  ProjectManager
//
//  Created by 무리 on 2023/05/19.
//

import Foundation

final class ListViewModel {
    var listArray: [ProjectModel] = [ProjectModel(title: "할 일 제목1할 일 제목1할 일 제목1할 일 제목1할 일 제목1할 일 제목1할 일 제목1할 일 제목1", description: "할 일 내용1", deadLine: Date(), state: .Todo),
                                 ProjectModel(title: "할 일 제목2", description: "할 일 내용2", deadLine: Date(), state: .Todo),
                                 ProjectModel(title: "할 일 제목3", description: "할 일 내용3", deadLine: Date(), state: .Todo),
                                 ProjectModel(title: "할 일 제목4", description: "할 일 내용4", deadLine: Date(), state: .Todo),
                                 ProjectModel(title: "할 일 제목21", description: "할 일 내용2할 일 내용2할 일 내용2할 일 내용2할 일 내용2할 일 내용2할 일 내용2할 일 내용2할 일 내용2할 일 내용2할 일 내용2할 일 내용2할 일 내용2할 일 내용2", deadLine: Date(), state: .Todo),
                                 ProjectModel(title: "한 일 제목1", description: "한 일 내용1\n한 일 내용1\n한 일 내용1\n한 일 내용1", deadLine: Date(), state: .Done),
                                 ProjectModel(title: "하는 중 제목1", description: "하는 중 내용1", deadLine: Date(), state: .Doing),
                                 ProjectModel(title: "하는 중 제목2", description: "하는 중 내용2", deadLine: Date(), state: .Doing)]
    
    var todoList: [ProjectModel]?
    
    var doingList: [ProjectModel]?
    
    var doneList: [ProjectModel]?
    
    var didChangedData: (([ProjectModel]) -> Void)?
    
    func bindList(handler: @escaping ([ProjectModel]) -> Void) {
        didChangedData = handler
    }

    func lineUpList(with state: State) -> [ProjectModel] {
        switch state {
        case .Todo:
            return listArray.filter({ $0.state == .Todo })
        case .Doing:
            return listArray.filter({ $0.state == .Doing })
        case .Done:
            return listArray.filter({ $0.state == .Done })
        }
    }
    
    func countProject(in state: State) -> Int {
        switch state {
        case .Todo:
            return listArray.filter({ $0.state == .Todo }).count
        case .Doing:
            return listArray.filter({ $0.state == .Doing }).count
        case .Done:
            return listArray.filter({ $0.state == .Done }).count
        }
    }

    func configureCell(to cell: TableViewCell, with data: ProjectModel) {
        cell.configureContent(with: data)
    }
    
    func append(newList: ProjectModel) {
        listArray.append(newList)
    }
    
    func delete(at index: Int) {
        listArray.remove(at: index)
    }
}

