//
//  BoardView.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture
import SwiftUI

struct BoardView: View {
  let store: StoreOf<BoardStore>
  
  var body: some View {
    HStack(spacing: 20) {
      BoardListView(
        boardListStore: store.scope(
          state: \.todoState,
          action: BoardStore.Action.todo
        )
      )
      .padding(.leading, 20)
      
      BoardListView(
        boardListStore: store.scope(
          state: \.doingState,
          action: BoardStore.Action.doing
        )
      )
      
      BoardListView(
        boardListStore: store.scope(
          state: \.doneState,
          action: BoardStore.Action.done
        )
      )
      .padding(.trailing, 20)
    }
  }
}

struct BoardView_Previews: PreviewProvider {
  static let store = Store(
    initialState: BoardStore.State(),
    reducer: BoardStore()
  )
  static var previews: some View {
    BoardView(store: store)
      .previewInterfaceOrientation(.landscapeLeft)
  }
}
