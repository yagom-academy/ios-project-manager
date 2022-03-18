import Foundation

struct Project {
    let id: UUID
    var title: String
    var description: String
    var date: Date
    var status: ProjectState
}

extension Project {
    init(title: String, description: String, date: Date) {
        self.init(
            id: UUID(),
            title: title,
            description: description,
            date: Date(),
            status: .todo
        )
    }
}

enum ProjectState: Int, CaseIterable {
    case todo = 0
    case doing = 1
    case done = 2
    
    var description: String {
        switch self {
        case .todo:
            return "TODO"
        case .doing:
            return "DOING"
        case .done:
            return "DONE"
        }
    }
    
    /**
     자기 자신을 제외한 나머지 case들의 description을 문자열 배열 형태로 반환합니다.
     
     예시로 todo 케이스의 경우 doing과 done의 description이 담긴 문자열 배열이 반환됩니다.
     ````
     let array = ProjectState.todo.excluded // ["DOING", "DONE"]
     ````
     */
    var excluded: [String] {
        switch self {
        case .todo:
            return [ProjectState.doing.description, ProjectState.done.description]
        case .doing:
            return [ProjectState.todo.description, ProjectState.done.description]
        case .done:
            return [ProjectState.todo.description, ProjectState.doing.description]
        }
    }
    
    /**
     전달받은 대문자 형태의 문자열 파라미터를 활용하여 ProjectState 인스턴스를 반환합니다.
     - Parameter text: 대문자 영문 문자열.
     
     case에 없는 문자열이라면 ProjectState.todo를 기본값으로 반환합니다.
     ````
     let doing = ProjectState.uppercased("Doing") // ProjectState.todo
     ````
     */
    static func uppercased(_ text: String) -> ProjectState {
        switch text {
        case "TODO":
            return ProjectState.todo
        case "DOING":
            return ProjectState.doing
        case "DONE":
            return ProjectState.done
        default:
            return ProjectState.todo
        }
    }
}
