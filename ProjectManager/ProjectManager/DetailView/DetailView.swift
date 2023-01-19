//
//  EditView.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI
import ComposableArchitecture

struct ProjectDetailView: View {
  let store: Store<DetailState, DetailAction>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      NavigationView {
        VStack {
          TextField(
            "Title",
            text: viewStore.binding(
              get: \.title,
              send: DetailAction._didChangeTitle
            )
          )
          .padding()
          .background(.white)
          .cornerRadius(10)
          .shadow(color: .gray, radius: 1, y: 1)
          
          DatePicker(
            "마감 기한",
            selection: viewStore.binding(
              get: \.deadLineDate,
              send: DetailAction._didChangeDeadLine
            ),
            in: Date()...,
            displayedComponents: .date
          )
          .environment(\.locale, Locale(identifier: "ko_KR"))
          .padding(10)
          .background(.white)
          .cornerRadius(10)
          .shadow(color: .gray, radius: 1, y: 1)
          
          TextEditor(
            text: viewStore.binding(
              get: \.description,
              send: DetailAction._didChangeDescription
            )
          )
          .padding()
          .background(.white)
          .cornerRadius(10)
          .shadow(color: .gray, radius: 1, y: 1)
        }
        .padding()
        .background(Color.secondaryBackground)
        .navigationTitle("TODO")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            Button("Cancel") {
              viewStore.send(.didCancelTap)
            }
          }
          
          ToolbarItem(placement: .navigationBarTrailing) {
            Button("Done") {
              viewStore.send(.didDoneTap)
            }
          }
        }
      }
      .navigationViewStyle(.stack)
      .onAppear {
        UITextView.appearance().backgroundColor = .clear
      }
    }
  }
}

struct DetailView_Previews: PreviewProvider {
  static let store = Store(
    initialState: DetailState(),
    reducer: detailReducer,
    environment: DetailEnvironment()
  )
  
  static var previews: some View {
    ProjectDetailView(store: store)
  }
}
