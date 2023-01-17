//
//  DetailViewStore.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.
        
import Foundation
import ComposableArchitecture

struct DetailViewStore: ReducerProtocol {
  struct State: Equatable {
    @BindableState var title: String = ""
    @BindableState var description: String = ""
    @BindableState var deadLineDate: Date = Date()
  }
  
  enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case didTapCancelButton
    case didTapDoneButton
  }
  
  var body: some ReducerProtocol<State, Action> {
    BindingReducer()
    
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
        
      case .didTapDoneButton, .didTapCancelButton:
        return .none
      }
    }
  }
}
