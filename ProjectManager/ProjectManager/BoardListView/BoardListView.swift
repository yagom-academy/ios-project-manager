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
      VStack(spacing: 0) {
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
          ) { listCellStore in
            WithViewStore(listCellStore) { cellStore in
              BoardListCell(store: listCellStore)
                .onTapGesture {
                  cellStore.send(.didSelectedEdit(true))
                }
                .sheet(
                  isPresented: .constant(cellStore.isSelected),
                  onDismiss: { cellStore.send(.didSelectedEdit(false)) }
                ) {
                  IfLetStore(listCellStore.scope(
                    state: \.detailState,
                    action: BoardListCellStore.Action.optionalDetailState
                  )) { detailState in
                    ProjectDetailView(store: detailState)
                  }
                }
            }

          }
          .onDelete { viewStore.send(.deleteProject($0)) }
          .menuStyle(.borderlessButton)
          .listRowSeparator(.hidden)
          .listRowInsets(Self.rowInset)
        }
        
      }
      .onAppear {
        UITableView.appearance().backgroundColor = .white
      }
    }
  }
}

extension BoardListView {
  static let rowInset = EdgeInsets(top: 5, leading: .zero, bottom: 5, trailing: .zero)
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
      .padding()
  }
}


//                IfLetStore(
//                  self.boardListStore.scope(
//                    state: \.selectedListCellState,
//                    action: BoardListStore.Action.optionalCellState
//                  )
//                ) { cellStore in
////                  IfLetStore(
////                    cellStore.scope(
////                      state: \.detailState,
////                      action: BoardListCellStore.Action.optionalDetailState
////                    )
////                  ) { detailStore in
////                    ProjectDetailView(store: detailStore)
////                  }
//                }
