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
    WithViewStore(store, observe: { $0 }) { viewStore in
      NavigationView {
        VStack(spacing: 20) {
          TextField("Title", text: viewStore.binding(\.$titleValue))
            .textFieldStyle(.plain)
            .padding(20)
            .background(.white)
            .cornerRadius(15)
            .shadow(color: .secondary, radius: 5, y: 3)
            .disabled(!viewStore.canEdit)
          
          DatePicker(
            selection: viewStore.binding(\.$selectedDate),
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
          
          TextEditor(text: viewStore.binding(\.$description))
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

struct ProjectEditView_Previews: PreviewProvider {
  static let store = Store(
    initialState: DetailViewReducer.State(canEdit: true),
    reducer: DetailViewReducer()
  )
  static var previews: some View {
    
    ProjectDetailView(store: store)
      .previewInterfaceOrientation(.landscapeLeft)
  }
}
