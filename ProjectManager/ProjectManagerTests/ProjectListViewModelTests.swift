import XCTest
import RxBlocking

class ProjectListViewModelTests: XCTestCase {

    var sut: ProjectListViewModel?
    
    override func setUpWithError() throws {
        sut = ProjectListViewModel()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
}
