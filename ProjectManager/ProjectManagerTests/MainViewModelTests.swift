//
//  ProjectManagerTests.swift
//  ProjectManagerTests
//
//  Created by 써니쿠키 on 2023/01/17.
//

import XCTest
@testable import ProjectManager

class MainViewModelTests: XCTestCase {
    var sut: MainViewModel?

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = MainViewModel()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    func test_readTitle_todo일때_TODO출력 () {
        // given: todo절차에서
        let process: Process = .todo
        
        // when: todo의 타이틀제목은
        let result = sut?.readTitle(of: process)
        
        // then: TODO다.
        XCTAssertEqual("TODO", result)
    }
    
    func test_registerProject_todo배열에_sampleData추가환인() {
        // given:  todo절차와, 샘플 데이터 Project가 있을 때
        let project = SampleData.project1
        let process = Process.todo
        
        // when: Project를 todo절차에 등록하면
        sut?.registerProject(project, in: process)
        
        // then: Project가 배열에 추가되었다.
        XCTAssertEqual([project], sut?.readData(in: .todo))
    }
    
    func test_editProject_배열에추가되어있는Data수정확인 () {
        // given: 샘플데이터 project가 doing절차에 등록되어 있을 때
        let process = Process.doing
        var project = SampleData.project1
        sut?.registerProject(project, in: process)
        
        // when: project의 제목을 수정하면
        project.title = "테스트수정제목"
        sut?.editProject(project, in: process)
        
        // then project의 제목이 수정되었다.
        XCTAssertEqual("테스트수정제목", sut?.readData(in: process).first?.title )
    }

    func test_deleteData_배열에추가되어있는Data삭제확인() {
        // given: 샘플데이터 project1, project2가 done절차에 등록되어 있을 때
        let process = Process.done
        let project1 = SampleData.project1
        let project2 = SampleData.project2
        sut?.registerProject(project1, in: process)
        sut?.registerProject(project2, in: process)
        
        // when: project1을 삭제하면
        sut?.deleteData(project1, in: process)
        
        // then: project1이 배열에서 제거되고 project2만 남아있다.
        XCTAssertEqual(project2, sut?.readData(in: process).first)
        XCTAssertNil(sut?.readData(in: process).lastIndex(of: project1))
    }
    
    func test_moveData_todo데이터를_doing으로이동확인() {
        // given: project1이 todo에 등록되어 있을 때
        let todoProcess = Process.todo
        let project = SampleData.project1
        sut?.registerProject(project, in: todoProcess)
        
        // when:
        let doingProcess = Process.doing
        sut?.moveData(project, from: .todo, to: .doing)
        
        // then:
        XCTAssertNil(sut?.readData(in: todoProcess).first)
        XCTAssertEqual(project, sut?.readData(in: doingProcess).first)
    }
}
