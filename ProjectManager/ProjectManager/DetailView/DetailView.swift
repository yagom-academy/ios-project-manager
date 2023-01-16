//
//  EditView.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI
import ComposableArchitecture

struct ProjectDetailView: View {
  let store: StoreOf<DetailViewStore>
  @State var text: String = ""
  @State var selectedDate: Date = Date()
  @State var description: String = ""
  var body: some View {
    NavigationView {
      VStack {
        TextField("Title", text: $text)
          .padding()
          .background(Color.secondaryBackground)
          .cornerRadius(10)
          .shadow(color: .gray, radius: 1, y: 1)
        
        DatePicker(
          "마감 기한",
          selection: $selectedDate,
          in: Date()...,
          displayedComponents: .date
        )
        .padding(10)
        .background(Color.secondaryBackground)
        .cornerRadius(10)
        .shadow(color: .gray, radius: 1, y: 1)
        
        TextEditor(text: $description)
          .padding()
          .background(Color.secondaryBackground)
          .cornerRadius(10)
      }
      .padding()
      .navigationTitle("TODO")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button("Cancel") {
            
          }
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
          Button("Done") {
            
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
