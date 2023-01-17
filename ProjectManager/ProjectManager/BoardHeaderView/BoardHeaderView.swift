//
//  BoardHeaderView.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI
import ComposableArchitecture

struct BoardHeaderView: View {
  let headerStore: StoreOf<BoardHeaderStore>
  
  var body: some View {
    WithViewStore(headerStore, observe: { $0 }) { viewStore in
      
      HStack {
        Text(viewStore.projectStatus.description)
          .font(.largeTitle)
          .bold()
          .padding(.horizontal)
          .foregroundColor(.white)
        
        Spacer()
        
        if viewStore.length > 2 {
          Text(viewStore.count.description)
            .font(.title)
            .bold()
            .padding(15)
            .background(
              Capsule()
                .fill(.white)
            )
        } else {
          Text(viewStore.count.description)
            .font(.title)
            .bold()
            .padding(15)
            .background(
              Circle()
                .fill(.white)
            )
        }
      }
      .padding()
      .background(Color.accentColor)
      .cornerRadius(20)
    }
  }
}

struct BoardHeaderView_Previews: PreviewProvider {
  static let headerStore = Store(
    initialState: BoardHeaderStore.State(
      count: 20000,
      projectStatus: .todo
    ),
    reducer: BoardHeaderStore()
  )
  
  static var previews: some View {
    BoardHeaderView(headerStore: headerStore)
      .previewInterfaceOrientation(.landscapeLeft)
      .previewLayout(.sizeThatFits)
      .frame(maxWidth: 450)
      .padding()
      
  }
}
