//
//  ListStoreTest.swift
//  NavigateStoreTest
//
//  Copyright (c) 2023 Minii All rights reserved.
        

import XCTest
import ComposableArchitecture

@testable import ProjectManager

@MainActor
class ListStoreTest: XCTestCase {
  func test_TodoStore타입이_잘작동하는지() async {
    
    let store = TestStore(
      initialState: TodoState(projects: Project.todoMockData),
      reducer: todoReducer,
      environment: TodoEnvironment()
    )
    
    await store.send(.didDelete(IndexSet(integer: 1))) {
      var result = Project.todoMockData
      result.remove(at: 1)
      $0.projects = result
    }
  }
}
