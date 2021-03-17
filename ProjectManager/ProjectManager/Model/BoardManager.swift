import Foundation

class BoardManager {
    static let shared = BoardManager()
    
    let todoBoard = Board(title: ProgressStatus.todo.rawValue)
    let doingBoard = Board(title: ProgressStatus.doing.rawValue)
    let doneBoard = Board(title: ProgressStatus.done.rawValue)
    lazy var boards: [Board] = {
        return [todoBoard, doingBoard, doneBoard]
    }()
    
    private init() {
        todoBoard.addItem(Item(title: "해야할 일 (1)", description: "오늘은 집안일을 해야한다. 빨래, 설거지, 청소기.... 힘든 주부의 삶", progressStatus: ProgressStatus.todo.rawValue, dueDate: 1621301220))
        todoBoard.addItem(Item(title: "해야할 일 (2)", description: "TIL과 수업 예습 복습을 잘해보자..!! 이번주 목요일 주제는 뭐였더라..?", progressStatus: ProgressStatus.todo.rawValue, dueDate: 1622301220))
        todoBoard.addItem(Item(title: "해야할 일 (3)", description: "이니 그린의 프로젝트 매니저 PR을 날려보자..! 얼마만인가 도대체! 고난과 역경을 딛고 일어선 대~~한~민국!", progressStatus: ProgressStatus.todo.rawValue, dueDate: 1820301220))
        doingBoard.addItem(Item(title: "하고있는 일 (1)", description: "프로젝트 매니저 Step1 리팩토링 및 BoardManager를 통한 구현", progressStatus: ProgressStatus.doing.rawValue, dueDate: 1625301220))
        doingBoard.addItem(Item(title: "하고있는 일 (2)", description: "숨쉬기", progressStatus: ProgressStatus.doing.rawValue, dueDate: 1625301220))
        doingBoard.addItem(Item(title: "하고있는 일 (3)", description: "프로젝트 안하고 유투브하고 넷플릭스보며 노는게 제일 좋아 친구들 모여라~!", progressStatus: ProgressStatus.doing.rawValue, dueDate: 1599301220))
        doneBoard.addItem(Item(title: "끝마친 일 (1)", description: "무엇을 끝냈더라???", progressStatus: ProgressStatus.done.rawValue, dueDate: 1598301220))
        doneBoard.addItem(Item(title: "끝마친 일 (2)", description: "드래그앤드롭 기능 구현 삽질...!", progressStatus: ProgressStatus.done.rawValue, dueDate: 1590301220))
        doneBoard.addItem(Item(title: "끝마친 일 (3)", description: "숙면하고 잘~~자기", progressStatus: ProgressStatus.done.rawValue, dueDate: 1000301220))
    }
}

let boardManager = BoardManager.shared
