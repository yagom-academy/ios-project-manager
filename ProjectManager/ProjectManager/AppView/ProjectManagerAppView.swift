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
          state: \.sheetState,
          action: AppAction.sheetAction
        )
      )
      
      HStack(spacing: 0) {
        BoardListView(
          store: self.store.scope(
            state: \.todoListState,
            action: AppAction.todoListAction
          )
        )
        
        BoardListView(
          store: self.store.scope(
            state: \.doingListState,
            action: AppAction.doingListAction
          )
        )
        
        BoardListView(
          store: self.store.scope(
            state: \.doneListState,
            action: AppAction.doneListAction
          )
        )
      }
    }
  }
}
