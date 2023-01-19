//
//  NavigateStoreTest.swift
//  NavigateStoreTest
//
//  Copyright (c) 2023 Minii All rights reserved.


import XCTest
import ComposableArchitecture
import Combine
import SwiftUI

@testable import ProjectManager

@MainActor
final class NavigateStoreTest: XCTestCase {
  func testNavigate() async {
    let store = TestStore(
      initialState: SheetState(),
      reducer: sheetReducer,
      environment: SheetEnvironment()
    )
    
    await store.send(._toggleNavigationState(true)) {
      $0.isPresent = true
    }
    
    await store.send(._toggleNavigationState(false)) {
      $0.isPresent = false
    }
  }
}
