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
        ProjectDetailView(
          store: Store(
            initialState: DetailViewStore.State(),
            reducer: DetailViewStore()
          )
        )
      }
      .onAppear {
        viewStore.send(.onAppear("Project Manager"))
      }
    }
  }
}
