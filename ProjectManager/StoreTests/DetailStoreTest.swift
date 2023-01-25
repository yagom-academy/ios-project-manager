//
//  DetailStoreTest.swift
//  NavigateStoreTest
//
//  Copyright (c) 2023 Minii All rights reserved.

import XCTest
import ComposableArchitecture

@testable import ProjectManager

@MainActor
final class DetailStoreTests: XCTestCase {
  func test_DetailStore가_잘작동하는지() async {
    let store = TestStore(
      initialState: DetailState(),
      reducer: detailReducer,
      environment: DetailEnvironment()
    )
    
    await store.send(._setNewTitle("테스트")) {
      $0.title = "테스트"
    }
    
    await store.send(._setNewDescription("테스트")) {
      $0.description = "테스트"
    }
    
    let result = Date(timeIntervalSince1970: 0)
    await store.send(._setNewDeadLine(Date(timeIntervalSince1970: 0))) {
      Thread.sleep(forTimeInterval: TimeInterval(1))
      $0.deadLineDate = result
    }
  }
}
