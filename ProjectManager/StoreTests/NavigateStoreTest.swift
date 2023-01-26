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
    
    await store.send(._setIsPresent) {
      $0.isPresent = true
    }
    
    await store.send(._setIsNotPresent) {
      $0.isPresent = false
    }
    
    let mockState = DetailState(title: "", description: "", deadLineDate: Date(), editMode: false)
    await store.send(
      ._createDetailState(
        id: mockState.id,
        currentDate: mockState.deadLineDate,
        isEdit: mockState.editMode
      )
    ) {
      $0.detailState = mockState
    }
    
    await store.send(._deleteDetailState) {
      $0.detailState = nil
    }
  }
}
