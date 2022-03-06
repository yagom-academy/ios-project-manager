import Foundation

protocol FireStoreUseCase {
    
    var path: String { get }
    
    func subscribe()
    func removeDataBase()
}
