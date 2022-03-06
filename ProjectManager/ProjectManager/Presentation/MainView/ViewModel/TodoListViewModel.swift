import Foundation
import RxSwift

class TodoListViewModel {
    
    private let managerFactory = ListManagerFactory()
    private var listManager: ListManager?
    private var dataList: Observable<[Listable]>?
    
    init() {
        self.listManager = managerFactory.assignListManger(
            database: DataBaseChecker.currentDataBase
        )
    }
}
