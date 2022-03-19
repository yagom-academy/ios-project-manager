import Foundation
import RxRelay
import RxSwift

final class ProjectHistoryCheckUseCase: HistoryCheckUseCase {
    
    var rxChangeHistories = BehaviorRelay<[(state: ManageState, identifier: String, object: Listable)]>(value: [])
    var chageHistory = [(state: ManageState, identifier: String, object: Listable)]()
    
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



