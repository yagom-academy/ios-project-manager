//
//  MainView.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI
import ComposableArchitecture

struct BoardView: View {
  let appStore: StoreOf<AppStore>
  
  var body: some View {
    NavigationView {
      WithViewStore(appStore) { viewStore in
        NavigationBarView(
          navigationStore: appStore.scope(
            state: \.navigationState,
            action: AppStore.Action.presentSheet
          )
        )
      }
    }
    .navigationViewStyle(.stack)
    
//    WithViewStore(appStore) { viewStore in
//      NavigationView {
//        VStack {
//
//
//          HStack(spacing: 0) {
//            ForEach(ProjectState.allCases, id: \.self) { state in
//              VStack(spacing: .zero) {
//                let selectedProject = viewStore.projects.filter { $0.state
//                   == state }
//                ListTitleView(title: state.description, count: selectedProject.count)
//
//                ProjectListView(projects: selectedProject)
//              }
//            }
//          }
//        }
//        .background(Color.white)
//        .navigationBarHidden(true)
//      }
//      .navigationViewStyle(.stack)
//    }
  }
}

private enum BoardViewNames {
  static let titleName: String = "Project Manager"
}

struct BoardViewPreviews: PreviewProvider {
  static let appReducer = Store(initialState: AppStore.State(), reducer: AppStore())
  static var previews: some View {
    BoardView(appStore: appReducer)
  }
}
