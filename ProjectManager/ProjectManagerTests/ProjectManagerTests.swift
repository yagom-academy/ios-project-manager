//
//  ProjectManagerTests.swift
//  ProjectManagerTests
//
//  Created by 김찬우 on 2021/06/30.
//

import XCTest
@testable import ProjectManager

class ProjectManagerTests: XCTestCase {
    let sut = Task(title: "야곰괴롭히기",
                        deadline: "2021-07-21",
                        description: "야곰을 충분히 괴롭혀주세요.")
    
    func test_할일등록화면에서_done_버튼을누를시_원하는모델객체가_생성되는가() {
        let registerViewController = RegisterViewController()
        let convertedModel = registerViewController.convertToModel(title: "야곰괴롭히기",
                                                                   dateString: "2021-07-21",
                                                                   description: "야곰을 충분히 괴롭혀주세요.")!
        
        XCTAssertEqual(sut.deadline, convertedModel.deadline)
    }
}
