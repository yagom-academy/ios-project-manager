//
//  MainView.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI
import ComposableArchitecture

struct BoardView: View {
  let boardReducer: StoreOf<BoardReducer>
  
  var body: some View {
    WithViewStore(boardReducer) { viewStore in
      NavigationView {
        VStack {
          NavigationTitleView(
            title: BoardViewNames.titleName,
            trailingImage: Image.plusImage,
            trailingAction: {
              viewStore.send(.didSetProject(true))
            }
          )
          
          HStack(spacing: 0) {
            ForEach(ProjectState.allCases, id: \.self) { state in
              VStack(spacing: .zero) {
                let selectedProject = viewStore.projects.filter { $0.state
                   == state }
                ListTitleView(title: state.description, count: selectedProject.count)
                
                ProjectListView(projects: selectedProject)
              }
            }
          }
        }
        .background(Color.white)
        .navigationBarHidden(true)
        .sheet(
          isPresented: viewStore.binding(
            get: \.isPresent,
            send: BoardReducer.Action.didSetProject
          )
        ) {
          
          IfLetStore(
            boardReducer.scope(
              state: \.detailViewState,
              action: BoardReducer.Action.optionalDetailViewState
            )
          ) { viewStore in
            ProjectDetailView(store: viewStore)
          }

        }
      }
      .navigationViewStyle(.stack)
    }
  }
}

private enum BoardViewNames {
  static let titleName: String = "Project Manager"
}

struct MainView_PreView: PreviewProvider {
  static let store = Store(
    initialState: BoardReducer.State(),
    reducer: BoardReducer()
  )
  static var previews: some View {
    if #available(iOS 15.0, *) {
      BoardView(boardReducer: store)
        .previewLayout(.sizeThatFits)
        .previewInterfaceOrientation(.landscapeLeft)
      
      BoardView(boardReducer: store)
        .previewLayout(.sizeThatFits)
        .previewInterfaceOrientation(.landscapeLeft)
        .preferredColorScheme(.dark)
      
    } else {
      BoardView(boardReducer: store)
        .previewLayout(.sizeThatFits)
    }
  }
}
