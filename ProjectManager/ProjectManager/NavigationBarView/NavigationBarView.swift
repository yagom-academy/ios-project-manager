//
//  NavigationBarView.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI
import ComposableArchitecture

struct NavigationBarView: View {
  let navigationStore: StoreOf<NavigationStore>
  
  var body: some View {
    WithViewStore(navigationStore, observe: { $0 }) { viewStore in
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
          send: NavigationStore.Action.didTapPresent
        )
      ) {
        IfLetStore(self.navigationStore.scope(
          state: \.detailState,
          action: NavigationStore.Action.optionalDetailState
        )) { viewStore in
          ProjectDetailView(store: viewStore)
        }
      }
      .onAppear {
        viewStore.send(.onAppear("Project Manager"))
      }
    }
  }
}

struct NavigationBarView_Previews: PreviewProvider {
  static let store = Store(initialState: NavigationStore.State(), reducer: NavigationStore())
  
  static var previews: some View {
    NavigationBarView(navigationStore: store)
  }
}
