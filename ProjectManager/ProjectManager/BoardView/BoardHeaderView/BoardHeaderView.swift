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
          .font(.title)
          .bold()
        
        Spacer()
        
        if viewStore.length > 2 {
          Text(viewStore.count.description)
            .padding(10)
            .background(
              Capsule()
                .fill(.white)
            )
        } else {
          Text(viewStore.count.description)
            .padding(10)
            .background(
              Circle()
                .fill(.white)
            )
        }
      }
      .padding()
      .background(Color.secondaryBackground)
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
      .padding()
  }
}
