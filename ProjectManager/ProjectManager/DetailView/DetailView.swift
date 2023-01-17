//
//  EditView.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI
import ComposableArchitecture

struct ProjectDetailView: View {
  let store: StoreOf<DetailViewStore>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      NavigationView {
        VStack {
          TextField("Title",text: viewStore.binding(\.$title))
            .padding()
            .background(.white)
            .cornerRadius(10)
            .shadow(color: .gray, radius: 1, y: 1)
          
          DatePicker(
            "마감 기한",
            selection: viewStore.binding(\.$deadLineDate),
            in: Date()...,
            displayedComponents: .date
          )
          .padding(10)
          .background(.white)
          .cornerRadius(10)
          .shadow(color: .gray, radius: 1, y: 1)
          
          TextEditor(text: viewStore.binding(\.$description))
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
              viewStore.send(.didTapCancelButton)
            }
          }
          
          ToolbarItem(placement: .navigationBarTrailing) {
            Button("Done") {
              viewStore.send(.didTapDoneButton)
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

struct ProjectDetailView_Previews: PreviewProvider {
  static let detailStore = Store(
    initialState: DetailViewStore.State(),
    reducer: DetailViewStore()
  )
  static var previews: some View {
    ProjectDetailView(store: detailStore)
      .previewLayout(.sizeThatFits)
  }
}
