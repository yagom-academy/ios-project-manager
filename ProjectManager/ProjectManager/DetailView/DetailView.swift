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
              send: DetailAction._setNewTitle
            )
          )
          .detailItemStyle()
          .disabled(!viewStore.isEditMode)
          
          DatePicker(
            "마감 기한",
            selection: viewStore.binding(
              get: \.deadLineDate,
              send: DetailAction._setNewDeadLine
            ),
            in: Date()...,
            displayedComponents: .date
          )
          .environment(\.locale, Locale(identifier: "ko_KR"))
          .detailItemStyle()
          .disabled(!viewStore.isEditMode)
          
          TextEditor(
            text: viewStore.binding(
              get: \.description,
              send: DetailAction._setNewDescription
            )
          )
          .detailItemStyle()
          .disabled(!viewStore.isEditMode)
        }
        .padding()
        .background(Color.secondaryBackground)
        .navigationTitle(viewStore.projectStatus.description)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            if viewStore.editMode {
              if viewStore.isEditMode {
                Button("Apply") {
                  UIApplication.shared.sendAction(
                    #selector(UIResponder.resignFirstResponder),
                    to: nil,
                    from: nil,
                    for: nil
                  )
                  viewStore.send(.didEditTap)
                }
              } else {
                Button("Edit") {
                  viewStore.send(.didEditTap)
                }
              }
            } else {
              Button("Cancel") {
                viewStore.send(.didCancelTap)
              }
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

private struct DetailItemModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .padding(10)
      .background(.white)
      .cornerRadius(10)
      .shadow(color: .gray, radius: 1, y: 1)
  }
}

private extension View {
  func detailItemStyle() -> some View {
    modifier(DetailItemModifier())
  }
}

struct DetailView_Previews: PreviewProvider {
  static let falseStore = Store(
    initialState: DetailState(),
    reducer: detailReducer,
    environment: DetailEnvironment()
  )
  
  static let trueStore = Store(
    initialState: DetailState(editMode: true),
    reducer: detailReducer,
    environment: DetailEnvironment()
  )
  
  static var previews: some View {
    ProjectDetailView(store: falseStore)
    ProjectDetailView(store: trueStore)
  }
}
