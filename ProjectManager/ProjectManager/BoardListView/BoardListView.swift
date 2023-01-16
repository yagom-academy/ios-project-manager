//
//  BoardListView.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI
import ComposableArchitecture

struct BoardListView: View {
  let boardListStore: StoreOf<BoardListStore>
  
  var body: some View {
    WithViewStore(boardListStore, observe: { $0 }) { viewStore in
      List {
        ForEachStore(
          boardListStore.scope(
            state: \.projects,
            action: BoardListStore.Action.projectItem(id:action:)
          )) { viewStore in
            BoardListCell(store: viewStore)
          }
          .listRowSeparator(.hidden)
      }
      .listStyle(.plain)
    }
  }
}

struct BoardListView_Previews: PreviewProvider {
  static let boardListStore = Store(
    initialState: BoardListStore.State(projects: Project.mock),
    reducer: BoardListStore()
  )
  static var previews: some View {
    BoardListView(boardListStore: boardListStore)
      .previewInterfaceOrientation(.landscapeLeft)
  }
}
