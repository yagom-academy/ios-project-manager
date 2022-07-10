//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/06.
//

import RxSwift
import RxRelay

final class MainViewModel {
    var listObservable = BehaviorRelay<[List]>(value: [])

    init() {
        addDummyData()
    }
    
    func isOverDeadline(list: List) -> Bool {
        return list.type != .done && list.deadline < Date()
    }
    
    func separatLists(_ type: ListType) -> Observable<[List]> {
        let list = listObservable
            .map{ $0.filter { $0.type == type }}
        return list
    }
    
    // MARK: - for test
    private func addDummyData() {
        let todoDummy: [List] = [
            List(title: "안녕이요", body: "네 저는 안녕이에요?", deadline: Date(timeIntervalSince1970: 16537259728), type: .todo),
            List(title: "안녕", body: "네 저는 안니근데 이렇게 죽ㅈ길게 써볼라는데 너는 뭐야!라이에요?", deadline: Date(timeIntervalSince1970: 751231235), type: .todo),
            List(title: "그래맞아", body: "네 \n저는 \n그래그래에요? \n그러면 말입니다", deadline: Date(timeIntervalSince1970: 1677269760), type: .todo)
        ]
        
        let doingDummy: [List] = [
            List(title: "나는 두잉이야", body: "ㅋㄷㅋㄷ 나 알아? 난 너 몰라", deadline: Date(timeIntervalSince1970: 1677269760), type: .doing),
            List(title: "안녕 나는 세잉이야", body: "모 \n 어쩔건데!! \n ㅋㄷㅋㄷ", deadline: Date(timeIntervalSince1970: 751231235), type: .doing)
        ]
        
        let doneDummy: [List] = [
            List(title: "나는 던이야", body: "노래는 못불러", deadline: Date(timeIntervalSince1970: 1677269760), type: .done),
            List(title: "안녕 똥이야!", body: "모 \n 어쩔건데!! \n ㅋㄷㅋㄷ", deadline: Date(timeIntervalSince1970: 751231235), type: .done)
        ]
        
        listObservable.accept((todoDummy + doingDummy + doneDummy)
            .sorted(by: { $0.deadline < $1.deadline}))
    }
}
