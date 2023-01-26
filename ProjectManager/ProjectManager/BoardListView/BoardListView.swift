//
//  BoardListView.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI
import ComposableArchitecture

struct BoardListView: View {
  let store: Store<BoardListState, BoardListAction>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      VStack(spacing: 10) {
        BoardListSectionHeader(
          projectState: viewStore.status,
          count: viewStore.projects.count
        )
        .padding()
        
        Divider()
          .frame(height: 2)
          .background(Color.accentColor)
          .padding(.horizontal)
          .cornerRadius(10)
        
        
        List(viewStore.projects, id: \.id) { project in
          BoardListCellView(project: project)
            .listRowInsets(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
            .listRowSeparator(.hidden)
            .onTapGesture {
              viewStore.send(.tapDetailShow(project))
            }
            .contextMenu {
              switch viewStore.status {
              case .todo:
                Button("DOING") {
                  viewStore.send(.movingToDoing(project))
                }
                
                Button("DONE") {
                  viewStore.send(.movingToDone(project))
                }

              case .doing:
                Button("TODO") {
                  viewStore.send(.movingToTodo(project))
                }
                
                Button("DONE") {
                  viewStore.send(.movingToDone(project))
                }
                
              case .done:
                Button("TODO") {
                  viewStore.send(.movingToTodo(project))
                }
                
                Button("DOING") {
                  viewStore.send(.movingToDoing(project))
                }
              }
            }
            .sheet(
              item: viewStore.binding(
                get: \.selectedProject,
                send: ._dismissItem
              )
            ) { store in
              IfLetStore(
                self.store.scope(
                  state: \.selectedProject,
                  action: BoardListAction.detailAction
                )
              ) { store in
                ProjectDetailView(store: store)
              }
            }
        }
        .listStyle(.plain)
      }
    }
  }
}
