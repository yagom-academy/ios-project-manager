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
          }
          .onDelete {
            viewStore.send(.didDelete($0))
          }
          .contextMenu {
            Button("Moving To Todo") {
              // TODO: send ViewStore action
            }
            
            Button("Moving To Done") {
              // TODO: send ViewStore action
            }
          }
        }
        .listStyle(.plain)
      }
    }
  }
}
