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
    @BindableState var titleValue = ""
    @BindableState var selectedDate = Date()
    @BindableState var description = ""
  }
  
  enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case didTapEdit
  }
  
  var body: some ReducerProtocol<State, Action> {
    BindingReducer()
    
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
        
      case .didTapEdit:
        state.canEdit.toggle()
        return .none
      }
    }
  }
}
