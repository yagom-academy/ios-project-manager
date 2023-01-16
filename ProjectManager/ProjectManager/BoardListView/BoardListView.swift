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
      VStack {
        BoardHeaderView(
          headerStore: boardListStore.scope(
            state: \.headerState,
            action: BoardListStore.Action.optionalHeader
          )
        )
        
        List {
          ForEachStore(
            boardListStore.scope(
              state: \.projects,
              action: BoardListStore.Action.projectItem(id:action:)
            )
          ) { viewStore in
            BoardListCell(store: viewStore)
          }
          .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
      }
    }
  }
}

struct BoardListView_Previews: PreviewProvider {
  static let boardListStore = Store(
    initialState: BoardListStore.State(
      status: .todo,
      projects: Project.mock
    ),
    reducer: BoardListStore()
  )
  static var previews: some View {
    BoardListView(boardListStore: boardListStore)
      .previewInterfaceOrientation(.landscapeLeft)
  }
}
