//
//  DoingBoardListView.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI
import ComposableArchitecture

struct DoingBoardListView: View {
  let store: Store<DoingState, DoingAction>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      VStack(spacing: 10) {
        BoardListSectionHeader(
          projectState: .doing,
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
                viewStore.send(.tapItem(true, project))
              }
              .contextMenu {
                Button("Moving To Todo") {
                  viewStore.send(.movingToTodo(project))
                }
                
                Button("Moving To Done") {
                  viewStore.send(.movingToDone(project))
                }
              }
              .sheet(
                isPresented: viewStore.binding(
                  get: \.isPresent,
                  send: DoingAction._changePresentState
                )
              ) {
                IfLetStore(
                  self.store.scope(
                    state: \.selectedState,
                    action: DoingAction.detailAction
                  )
                ) {
                  ProjectDetailView(store: $0)
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
