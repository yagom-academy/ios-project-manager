import XCTest


class ProjectManagerModelTests: XCTestCase {
    
    var sut: WorkMemoryManager?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = WorkMemoryManager()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    // MARK: - create 메서드 검증
    func test_create_will_make_appropriate_Work_instance_in_todo_storage() {
        var firstWork = Work()
        firstWork.title = "a"
        firstWork.body = "a"
        firstWork.dueDate = Date()
        sut?.create(firstWork)
        
        XCTAssertFalse(sut?.todoList == nil)
        XCTAssertEqual(firstWork.title, sut?.todoList[0].title)
    }
    
    func test_create_will_not_make_Work_instance_in_doing_storage() {
        let firstWork = Work(title: "a", body: "a", dueDate: Date())
        sut?.create(firstWork)
        guard let sut = sut else { return }

        XCTAssertTrue(sut.doingList.isEmpty)
    }
    
    func test_create_two_element_which_have_different_id() {
        let firstWork = Work()
        let secondWork = Work()

        XCTAssertNotEqual(firstWork.id, secondWork.id)
    }
    
    // MARK: - delete 메서드 검증
    func test_delete_will_remove_right_data() {
        let firstWork = Work()
        let secondWork = Work()
        sut?.create(firstWork)
        sut?.create(secondWork)
        try? sut?.delete(secondWork)
        guard let sut = sut else { return }
        
        XCTAssertEqual(sut.todoList[0].id, firstWork.id)
        XCTAssertEqual(sut.todoList.count, 1)
    }
    
    func test_delete_will_remove_right_data_in_array_with_four_elements() {
        let firstWork = Work()
        let secondWork = Work()
        let thirdWork = Work()
        let fourthWork = Work()
        sut?.create(firstWork)
        sut?.create(secondWork)
        sut?.create(thirdWork)
        sut?.create(fourthWork)
        try? sut?.delete(thirdWork)
        guard let sut = sut else { return }
        
        XCTAssertEqual(sut.todoList[0].id, firstWork.id)
        XCTAssertEqual(sut.todoList[1].id, secondWork.id)
        XCTAssertEqual(sut.todoList[2].id, fourthWork.id)
    }
    
    // MARK: - update 메서드 검증
    func test_update_will_change_right_property() {
        var firstWork = Work()
        firstWork.title = "a"
        firstWork.body = "가나다"
        firstWork.dueDate = Date()
        sut?.create(firstWork)
        sut?.update(firstWork, title: "b", body: "가나다", date: Date())
        
        XCTAssertEqual(sut?.todoList[0].title, "b")
    }
    
}
