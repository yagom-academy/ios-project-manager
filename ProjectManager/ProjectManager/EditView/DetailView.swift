//
//  EditView.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI
import ComposableArchitecture

struct ProjectDetailView: View {
  @Environment(\.dismiss) var dismiss
  let store: StoreOf<DetailViewReducer>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      NavigationView {
        VStack(spacing: 20) {
          TextField(
            "Title",
            text: Binding(
              get: { viewStore.titleValue },
              set: { viewStore.send(.didChangeTitle($0)) })
          )
          .textFieldStyle(.plain)
          .padding(20)
          .background(.white)
          .cornerRadius(15)
          .shadow(color: .secondary, radius: 5, y: 3)
          .disabled(!viewStore.canEdit)
          
          DatePicker(
            selection: Binding(
              get: { viewStore.selectedDate },
              set: { viewStore.send(.didChangeSelectedDate($0)) }
            ),
            in: Date()...,
            displayedComponents: .date
          ) {
            Text("마감 기한")
              .font(.system(size: 20, weight: .semibold))
          }
          .padding(20)
          .background(.white)
          .cornerRadius(15)
          .shadow(color: .secondary, radius: 5, y: 3)
          .disabled(!viewStore.canEdit)
          
          TextEditor(
            text: Binding(
              get: { viewStore.description },
              set: { viewStore.send(.didChangeDescription($0)) }
            )
          )
          .padding(20)
          .background(.white)
          .cornerRadius(15)
          .shadow(color: .secondary, radius: 5, y: 3)
          .disabled(!viewStore.canEdit)
        }
        .padding(10)
        .navigationTitle("TODO")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            Button {
              viewStore.send(.didTapEdit)
            } label: {
              Text(viewStore.canEdit ? "Apply" : "Edit")
            }
          }
          
          
          ToolbarItem(placement: .navigationBarTrailing) {
            Button {
              dismiss()
            } label: {
              Text("Done")
            }
          }
        }
      }
      .navigationViewStyle(.stack)
    }
  }
}
