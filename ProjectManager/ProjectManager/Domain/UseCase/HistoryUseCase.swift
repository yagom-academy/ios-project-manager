import Foundation
import RxSwift
import RxRelay

protocol HistoryCheckUseCase {
    
    var rxChangeHistories: BehaviorRelay<[(state: ManageState, identifier: String, object: Listable)]> { get set }
    
    func saveDifference(method: ManageState, identifier: String, object: Listable)
}
