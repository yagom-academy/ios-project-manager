//
//  TodoBoardListView.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.


import SwiftUI
import ComposableArchitecture

struct TodoBoardListView: View {
  let store: Store<TodoState, TodoAction>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      VStack(spacing: 10) {
        BoardListSectionHeader(
          projectState: .todo,
          count: viewStore.projects.count
        )
        .padding()
        
        Divider()
          .frame(height: 2)
          .background(Color.accentColor)
          .padding(.horizontal)
          .cornerRadius(10)
        
        
        List {
          ForEach(viewStore.projects, id: \.id) { project in
            BoardListCellView(project: project)
              .listRowInsets(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
              .listRowSeparator(.hidden)
              .onTapGesture {
                viewStore.send(._setSelectedState(project))
              }
              .contextMenu {
                Button("Moving To Doing") {
                  viewStore.send(.movingToDoing(project))
                }
                
                Button("Moving To Done") {
                  viewStore.send(.movingToDone(project))
                }
              }
              .sheet(
                item: viewStore.binding(
                  get: \.selectedProject,
                  send: TodoAction._setSelectedState
                )
              ) { _ in
                IfLetStore(
                  self.store.scope(
                    state: \.selectedState,
                    action: TodoAction.detailAction
                  )
                ) {
                  ProjectDetailView(store: $0)
                } else: {
                  Text("없어짐")
                }
              }
              
          }
          .onDelete {
            viewStore.send(.didDelete($0))
          }
          
        }
        .listStyle(.plain)
        
      }
    }
  }
}
