import Foundation
import RxSwift
import RxRelay

protocol HistoryCheckUseCase {
    
    var changedHistory: BehaviorRelay<[(state: ManageState, identifier: String, object: Listable)]> { get }
    
    func saveDifference(method: ManageState, identifier: String, object: Listable)
}
