//
//  EditingViewModelTests.swift
//  ProjectManagerTests
//
//  Created by 써니쿠키 on 2023/01/17.
//

import XCTest
@testable import ProjectManager

class EditingViewModelTests: XCTestCase {
    var sut: EditingViewModel?
    var mainViewModel: MainViewModel?
    var project: Project?
    
    override func setUpWithError() throws {
        try super .setUpWithError()
        
        mainViewModel = MainViewModel()
        project = SampleData.project1
        
        guard let mainViewModel = mainViewModel,
              let project = project else { return }
        
        sut = EditingViewModel(editTargetModel: mainViewModel, project: project)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_changeModeToEditable_mode를_editable로변경확인() {
        // given: 추가되어있던 데이터의 수정모드라서 처음에 realOnly모드일 때
        let project = SampleData.project2
        let mainViewModel = MainViewModel()
        mainViewModel.add(project, in: .doing)
        
        sut = EditingViewModel(editTargetModel: mainViewModel,
                               project: project,
                               isNewProject: false,
                               state: .doing)
        
        // when: 모드를 변경하면
        sut?.changeModeToEditable()
        
        // then: editable한 모드이다
        XCTAssertTrue(sut!.isEditable)
    }
    
    func test_registerProject () {
        // given, when: 프로젝트를 등록하면
        guard let project = project else { return }
        sut?.register(project)
        
        // then: mainViewModel의 todo배열에 추가된다.
        let addedData = mainViewModel?.fetchProject(index: 0, of: .todo)
        XCTAssertEqual(project.title, addedData?.title)
        XCTAssertEqual(project.description, addedData?.description)
        XCTAssertEqual(project.date, addedData?.date)
    }
    
    func test_editProject () {
        // given: doing 배열에 추가되어있던 프로젝트데이터가 있을 때
        var project = SampleData.project2
        let mainViewModel = MainViewModel()
        mainViewModel.add(project, in: .doing)
        
        sut = EditingViewModel(editTargetModel: mainViewModel,
                               project: project,
                               isNewProject: false,
                               state: .doing)
        
        // when: project를 수정한 후
        project.title = "수정된 타이틀"
        project.description = "수정된 Description"
        sut?.edit(project)
        
        // then: 등록되어있던 doing배열의 project데이터가 수정된다.
        guard let editedData = mainViewModel.fetchProject(index: 0, of: .doing) else {
            XCTFail("fetchProject Index 범위 초과")
            return
        }
        
        XCTAssertEqual("수정된 타이틀", editedData.title)
        XCTAssertEqual("수정된 Description", editedData.description)
    }
    
    func test_doneEditing_새로운_프로젝트일때mainModelView_Todo에_데이터추가확인() {
        // given: 새로운 프로젝트를 등록하는 과정일 때,
        let newProject = Project(title: "new", description: "test", date: Date(), uuid: UUID())
        
        // when: 수정을 끝내면
        sut?.doneEditing(titleInput: newProject.title,
                         descriptionInput: newProject.description,
                         dateInput: newProject.date)
        
        // then: mainViewModel의 TODO에 추가된다.
        let addedData = mainViewModel?.fetchProject(index: 0, of: .todo)
        XCTAssertEqual(newProject.title, addedData?.title)
        XCTAssertEqual(newProject.description, addedData?.description)
        XCTAssertEqual(newProject.date, addedData?.date)
    }
    
    func test_doneEditing_기존에있던_프로젝트일때_데이터수정확인() {
        // given: doon 배열에 추가되어있던 프로젝트데이터가 있을 때
        var project = SampleData.project2
        let mainViewModel = MainViewModel()
        mainViewModel.add(project, in: .done)
        
        sut = EditingViewModel(editTargetModel: mainViewModel,
                               project: project,
                               isNewProject: false,
                               state: .done)
        
        // when: 프로젝트 내용을 바꾸고 수정을 끝내면
        project.title = "수정된 테스트 Ttile"
        project.description = "수정된 테스트 Description"
        sut?.doneEditing(titleInput: project.title,
                         descriptionInput: project.description,
                         dateInput: project.date)
        
        // then: mainViewModel의 TODO에 추가된다.
        guard let editedData = mainViewModel.fetchProject(index: 0, of: .done) else {
            XCTFail("fetchProject Index 범위 초과")
            return
        }
        XCTAssertEqual("수정된 테스트 Ttile", editedData.title)
        XCTAssertEqual("수정된 테스트 Description", editedData.description)
    }
}
