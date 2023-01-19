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
    
    await store.send(.didTapPresent(true)) {
      $0.isPresent = true
      $0.detailState = DetailState()
    }
    
    await store.send(.didTapPresent(false)) {
      $0.isPresent = false
      $0.detailState = nil
    }
  }
}
