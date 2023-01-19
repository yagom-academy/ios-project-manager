//
//  NavigationBarView.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI
import ComposableArchitecture

struct NavigationBarView: View {
  let navigationStore: Store<NavigateState, NavigateAction>
  
  var body: some View {
    WithViewStore(navigationStore) { viewStore in
      ZStack {
        HStack {
          Spacer()
          
          Text(viewStore.title)
            .foregroundColor(.accentColor)
            .customTitleStyle()
          
          Spacer()
        }
        
        HStack {
          Spacer()
          
          Button {
            viewStore.send(.didTapPresent(true))
          } label: {
            Image(systemName: "plus")
              .customTitleStyle()
          }
        }
        .padding([.vertical, .trailing])
      }
      .background(Color.secondaryBackground)
      .sheet(
        isPresented: viewStore.binding(
          get: \.isPresent,
          send: NavigateAction.didTapPresent
        )
      ) {
        // TODO: - Navigate Present Item
      }
    }
  }
}

struct NavigationBarView_Previews: PreviewProvider {
  static let store = Store(
    initialState: NavigateState(),
    reducer: navigateReducer,
    environment: NavigateEnvironment()
  )
  
  static var previews: some View {
    NavigationBarView(navigationStore: store)
  }
}
