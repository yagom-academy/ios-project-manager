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
    
    func test_generateNewProject_프로젝트인스턴스생성() {
        // given, when: 새로운 프로젝트를 만들면
        let result = sut?.generateNewProject()
        
        // then: Title, Description이 빈 값인 새로운 Project 객체가 생성된다
        XCTAssertEqual("", result?.title)
        XCTAssertEqual("", result?.detail)
    }

    func test_readTitle_todo일때_TODO출력() {
        // given: todo절차에서
        let state = ProjectState.todo
        
        // when: todo의 타이틀제목은
        let result = sut?.readTitle(of: state)
        
        // then: TODO다.
        XCTAssertEqual("TODO", result)
    }
    
    func test_fetchProjects_state에맞는Project배열반환() {
        // given: todo상태에 Project 2개 추가시
        let project1 = SampleData.project1
        let project2 = SampleData.project2
        sut?.save(project1, in: .todo)
        sut?.save(project2, in: .todo)
        
        // when: todo상태에 프로젝트 배열을 fetchProjects하면
        let result = sut?.fetchProjects(of: .todo)
        
        // then: [project1, project2]배열을 반환한다
        XCTAssertEqual([project1, project2], result)
    }
    
    func test_fetchProject_state와_index에해당하는_Project객체반환() {
        // given: doing배열의 0번째, 1번째로 Project 2개 추가시
        let project1 = SampleData.project1
        let project2 = SampleData.project2
        sut?.save(project1, in: .doing)
        sut?.save(project2, in: .doing)
        
        // when: doing배열의 Index 0,1을 fetchProject하면
        let result1 = sut?.fetchProject(index: 0, of: .doing)
        let result2 = sut?.fetchProject(index: 1, of: .doing)
        
        // then: 각각 project1, project2를 반환한다
        XCTAssertEqual(project1, result1)
        XCTAssertEqual(project2, result2)
    }
    
    func test_fetchProject_index가범위를초과하면_nil반환() {
        // given: doing배열의 0번째, 1번째로 Project 2개 추가시
        let project1 = SampleData.project1
        let project2 = SampleData.project2
        sut?.save(project1, in: .doing)
        sut?.save(project2, in: .doing)
        
        // when: doing배열의 index가범위를 초과한 Index 2를 fetchProject하면
        let result = sut?.fetchProject(index: 2, of: .doing)
        
        // then: nil을반환한다
        XCTAssertNil(result)
    }
    
    func test_save_기존배열에_없을때_배열에추가() {
        // given: todo배열에 project1이 없을 때
        let project1 = SampleData.project1
        XCTAssertEqual([], sut?.fetchProjects(of: .todo))

        // when: Project를 todo배열에 save하면
        sut?.save(project1, in: .todo)
        let result = sut?.fetchProjects(of: .todo)

        // then: todo배열에 Project가 추가된다.
        XCTAssertEqual([project1], result)
    }
    
    func test_save_기존배열에_있을때_기존값수정() {
        // given: todo배열에 project1이 있을 때
        var project1 = SampleData.project1
        sut?.save(project1, in: .todo)
        XCTAssertEqual([project1], sut?.fetchProjects(of: .todo))

        // when: Project1을 수정하고 save하면
        project1.title = "수정후 타이틀"
        sut?.save(project1, in: .todo)
        let result = sut?.fetchProjects(of: .todo)

        // then: todo배열에 기존 Project1이 수정된다.
        XCTAssertEqual([project1], result)
        XCTAssertEqual("수정후 타이틀", result?[0].title)
    }

    func test_deleteData_배열에추가되어있는Data삭제확인() {
        // given: done배열에 project1, project2가 있을 때,
        let project1 = SampleData.project1
        let project2 = SampleData.project2
        sut?.save(project1, in: .done)
        sut?.save(project2, in: .done)
        
        // when: project1을 삭제하면
        sut?.delete(project1, of: .done)
        
        // then: project1이 배열에서 제거되고 project2만 남아있다.
        XCTAssertEqual(project2, sut?.fetchProject(index: 0, of: .done))
        XCTAssertNil(sut?.fetchProjects(of: .done).lastIndex(of: project1))
    }
    
    func test_moveData_todo데이터를_doing으로이동확인() {
        // given: todo 배열에 project1 한 개가 있을 때
        let todoState = ProjectState.todo
        let project1 = SampleData.project1
        sut?.save(project1, in: todoState)
        
        // when: doing배열로 project1을 이동시키면
        let doingState = ProjectState.doing
        sut?.move(project1, from: .todo, to: .doing)
        
        // then: toto배열은 비고, doing배열에 project1이 있다.
        XCTAssertNil(sut?.fetchProjects(of: todoState).first)
        XCTAssertEqual(project1, sut?.fetchProject(index: 0, of: doingState))
    }
}
