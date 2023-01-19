//
//  ProjectManagerAppView.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.
        
import SwiftUI
import ComposableArchitecture

struct ProjectManagerAppView: View {
  let store: Store<AppState, AppAction>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      NavigationBarView(
        navigationStore: self.store.scope(
          state: \.navigateState,
          action: AppAction.navigateAction
        )
      )
      
      HStack {
        BoardListView(
          store: self.store.scope(
            state: \.todoListState,
            action: AppAction.todoListAction
          )
        )
        
        BoardListView(
          store: self.store.scope(
            state: \.todoListState,
            action: AppAction.todoListAction
          )
        )
        
        BoardListView(
          store: self.store.scope(
            state: \.todoListState,
            action: AppAction.todoListAction
          )
        )
      }
    }
  }
}
