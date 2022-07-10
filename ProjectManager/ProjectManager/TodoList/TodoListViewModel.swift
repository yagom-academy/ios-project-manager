//
//  TodoListViewModel.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/05.
//

import Foundation

import RxCocoa
import RxRelay
import RxSwift

final class TodoListViewModel {
    let todoViewData: Driver<[Todo]>
    let doingViewData: Driver<[Todo]>
    let doneViewData: Driver<[Todo]>
    
    private let mockData = BehaviorRelay<[Todo]>(value: [
        Todo(status: .todo, title: "책상정리", description: "집중이 안될때 역시나 책상정리", date: CurrentDateFormatter.fetch()),
        Todo(status: .done, title: "TIL 작성하기", description: "TIL 작성하면\n오늘의 상큼한 마무리도 되고\n나중에 포트폴리오 용으로 좋죠!", date: CurrentDateFormatter.fetch()),
        Todo(status: .doing, title: "오늘의 할일 찾기", description: "내가 가는 이길이 어디로 가는지 날 데려가는지 그곳은 어딘지 알 수 없지만 알 수 없지만 오늘도 난 걸어가고 있네 사람들은 길이 다 정해져 있지 내가 가는 길이 어디로 가는지 잘 모르겠지만 활 수 있따!", date: CurrentDateFormatter.fetch()),
        Todo(status: .todo, title: "프로젝트 회고 작성", description: "프로젝트 회고를 작성하면 내가 이번 프로젝트에서\n무엇을 놓쳤는지 명확히 알 수 있어요.", date: CurrentDateFormatter.fetch())
    ])
    
    init() {
        todoViewData = mockData
            .map { $0.filter { $0.status == .todo } }
            .asDriver(onErrorJustReturn: [])
        
        doingViewData = mockData
            .map { $0.filter { $0.status == .doing } }
            .asDriver(onErrorJustReturn: [])
        
        doneViewData = mockData
            .map { $0.filter { $0.status == .done } }
            .asDriver(onErrorJustReturn: [])
    }
}
