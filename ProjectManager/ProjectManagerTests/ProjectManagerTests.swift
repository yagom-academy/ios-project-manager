//
//  ProjectManagerTests.swift
//  ProjectManagerTests
//
//  Created by 김찬우 on 2021/06/30.
//

import XCTest
@testable import ProjectManager

class ProjectManagerTests: XCTestCase {
    let sut = TODOModel(title: "야곰괴롭히기",
                        deadline: <#T##Date#>,
                        description: <#T##String#>)
    
    func test_할일등록화면에서_done_버튼을누를시_원하는모델객체가_생성되는가() {
        XCTAssertEqual(<#T##expression1: Equatable##Equatable#>, <#T##expression2: Equatable##Equatable#>)
    }
}
