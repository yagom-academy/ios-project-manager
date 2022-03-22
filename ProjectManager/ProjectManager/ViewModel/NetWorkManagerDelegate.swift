import Foundation

protocol NetWorkManagerDelegate: AnyObject {
    var errorAlert: ErrorModel? { get set }
    func synchronizeFirebaseWithRealm()
}
