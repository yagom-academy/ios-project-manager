import Foundation
import RxRelay
import RxSwift

final class ProjectHistoryCheckUseCase: HistoryCheckUseCase { // model을 holding하는 Layer가 아니다
    
    var rxChangeHistories = BehaviorRelay<[(state: ManageState, identifier: String, object: Listable)]>(value: [])
    var chageHistory = [(state: ManageState, identifier: String, object: Listable)]() // repository <model>
    
    func fetchHistory() -> Observable<[(state: ManageState, identifier: String, object: Listable)]>{
        return Observable.create { emitter in
            emitter.onNext(self.chageHistory)
            return Disposables.create {
                
            }
        }
    }
    
    func saveDifference(method: ManageState, identifier: String, object: Listable) {
        chageHistory.append((state: method, identifier: identifier, object: object))
    }
}



