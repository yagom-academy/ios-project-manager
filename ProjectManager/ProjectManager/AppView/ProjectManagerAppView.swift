//
//  ProjectManagerAppView.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.
        
import SwiftUI
import ComposableArchitecture

struct ProjectManagerAppView: View {
  let store: StoreOf<AppStore>
  
  var body: some View {
    VStack(spacing: 20) {
      NavigationBarView(
        navigationStore: self.store.scope(
          state: \.navigationState,
          action: AppStore.Action.presentSheet
        )
      )
      
      BoardView(
        store: store.scope(
          state: \.boardState,
          action: AppStore.Action.boardView
        )
      )
    }
  }
}

struct ProjectManagerAppView_Previews: PreviewProvider {
  static let store = Store(
    initialState: AppStore.State(),
    reducer: AppStore()
  )
  static var previews: some View {
    ProjectManagerAppView(store: store)
      .previewInterfaceOrientation(.landscapeLeft)
  }
}
