import Foundation
import RxRelay
import RxSwift

final class ProjectHistoryCheckUseCase: HistoryCheckUseCase {
    //TODO: - model을 holding하는 Layer 만들기
    
    var changedHistory = BehaviorRelay<[(state: ManageState, identifier: String, object: Listable)]>(value: [])
    var chageHistory = [(state: ManageState, identifier: String, object: Listable)]()
    //TODO: - repository <model>로 분리 
    
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



