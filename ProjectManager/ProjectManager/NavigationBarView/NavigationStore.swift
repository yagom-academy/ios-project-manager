//
//  NavigationStore.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture
import SwiftUI

struct NavigationStore: ReducerProtocol {
  struct State: Equatable {
    var isPresent: Bool = false
    var title: String = ""
    var trailingImage: Image?
    var leadingImage: Image?
  }
  
  enum Action: Equatable {
    case onAppear(String)
    case didTapPresent(Bool)
  }
  
  func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
    case let .onAppear(titleValue):
      state.title = titleValue
      return .none
      
    case let .didTapPresent(isPresent):
      state.isPresent = isPresent
      return .none
    }
  }
}
