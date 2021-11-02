//
//  ToDoListViewModel.swift
//  ProjectManager
//
//  Created by KimJaeYoun on 2021/11/02.
//

import Foundation

enum Action  {
    case create
    case onAppear
}

protocol ViewModel: ObservableObject {
    associatedtype Input
    associatedtype Output
    
    func action(_ action: Input)
}

final class ToDoListViewModel: ViewModel {
    typealias Input = Action
    typealias Output = [Todo]
    
    //output
    @Published var toDoList: Output = []
    
    // task 추가
    
    //Output
    
    func action(_ action: Input) {
        switch action {
        case .create:
            print("qwe")
        case .onAppear:
            print("asdasd")
        }
    }
    //Input
    //사용자의 입력
//    viewmodel.action(.create)
//    viewmodel.action(.delete)
//    func action(_ action: Action) {
//        switch action {
//        case .create:
//            //실행~ 만들어줘
//            //toDoList.append(model)
//        case .onAppear:
//            // 실행
//            // 화면 로드될때 뭘 해줄거니?
//        case didTapCell:
//        case delete:
//
//        }
//    }
}
