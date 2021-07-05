//
//  MockJSONData.swift
//  ProjectManager
//
//  Created by Seungjin Baek on 2021/07/05.
//

import UIKit

enum MockTaskType: String {
    case todo, doing, done
    
    var description: String {
        switch self {
        case .todo:
            return "todo"
        case .doing:
            return "doing"
        case .done:
            return "done"
        }
    }
    
    var model: [Task]? {
        switch self {
        case .todo:
            return self.taskArrayFromAsset()
        case .doing:
            return self.taskArrayFromAsset()
        case .done:
            return self.taskArrayFromAsset()
        }
    }
    
    private func taskArrayFromAsset() -> [Task]? {
        guard let dataAsset = NSDataAsset.init(name: self.description),
        let model = try? JSONDecoder().decode([Task].self, from: dataAsset.data) else { return nil }
        return model
    }
}

struct MockJSONData {
    
    var mockToDoList: [Task]
    var mockDoingList: [Task]
    var mockDoneList: [Task]
    
    init?() {
        if let toDoList = MockTaskType.todo.model,
           let doingList = MockTaskType.doing.model,
           let doneList = MockTaskType.done.model {
            self.mockToDoList = toDoList
            self.mockDoingList = doingList
            self.mockDoneList = doneList
        } else { return nil }
    }
    
    mutating func parseJSON(fileName: MockTaskType) throws {
        guard let dataAsset = NSDataAsset.init(name: fileName.description) else { throw DragAndDropError.jsonParsingError }
        do {
            let jsonData = try JSONDecoder().decode([Task].self, from: dataAsset.data)
            switch fileName {
            case .todo:
                mockToDoList = jsonData
            case .doing:
                mockDoingList = jsonData
            case .done:
                mockDoneList = jsonData
            }
        } catch {
            throw DragAndDropError.jsonParsingError
        }
    }
    
    mutating func moveTaskfromToDoToDoing(fromIndexOfToDo source: Int, toIndexOfDoing destination: Int) {
        mockDoingList.insert(mockToDoList[source], at: destination)
        mockToDoList.remove(at: source)
    }
}
