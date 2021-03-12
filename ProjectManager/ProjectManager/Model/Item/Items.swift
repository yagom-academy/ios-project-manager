import Foundation

final class Items {
    static let shared = Items()
    var todoList = [Item]()
    var doingList = [Item]()
    var doneList = [Item]()
    
    private init() {}
}
