import XCTest
import RxBlocking
import RxSwift
import RxTest

class ProjectListViewModelTests: XCTestCase {

    var viewModel: ProjectListViewModel?
    var disposeBag: DisposeBag!
    var scheduler: TestScheduler!
    
    override func setUpWithError() throws {
        self.viewModel = ProjectListViewModel(coordinator: MainCoordinator())
        self.disposeBag = DisposeBag()
        self.scheduler = TestScheduler(initialClock: 0)
    }
    
    override func tearDownWithError() throws {
        self.viewModel = nil
        self.disposeBag = nil
    }
    
    func test_() {
        
    }
}
