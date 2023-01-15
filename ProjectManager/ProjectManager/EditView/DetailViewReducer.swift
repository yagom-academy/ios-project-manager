//
//  DetailViewReducer.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.
        
import SwiftUI
import ComposableArchitecture

struct DetailViewReducer: ReducerProtocol {
  struct State: Equatable {
    var canEdit: Bool
    var titleValue = ""
    var selectedDate = Date()
    var description = ""
  }
  
  enum Action: Equatable {
    case didTapEdit
    case didChangeTitle(String)
    case didChangeSelectedDate(Date)
    case didChangeDescription(String)
    case dismissButtonTap
  }
  
  func reduce(into state: inout State, action: Action) -> ComposableArchitecture.EffectTask<Action> {
    switch action {
    case .didTapEdit:
      state.canEdit.toggle()
      return .none
      
    case let .didChangeTitle(title):
      state.titleValue = title
      return .none
      
    case let .didChangeSelectedDate(date):
      state.selectedDate = date
      return .none
      
    case let .didChangeDescription(body):
      state.description = body
      return .none
    case .dismissButtonTap:
      return .none
    }
  }
  
}
