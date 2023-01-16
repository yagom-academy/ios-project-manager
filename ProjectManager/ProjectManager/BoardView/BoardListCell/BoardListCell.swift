//
//  BoardListCell.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI
import ComposableArchitecture

struct BoardListCell: View {
  let store: StoreOf<BoardListCellStore>
  
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      VStack(alignment: .leading, spacing: 10) {
        Text(viewStore.title)
          .font(.title2)
          .bold()
        
        Text(viewStore.description)
          .font(.system(.body))
        
        Text(viewStore.deadLineDate.description)
          .font(.caption)
      }
      .padding()
      .background(Color.secondaryBackground)
      .cornerRadius(15)
    }
  }
}

struct BoardListCell_Previews:PreviewProvider {
  static let listCellStore = Store(initialState: BoardListCellStore.State(title: "Example", description: "ExampleExampleExampleExampleExampleExampleExample", deadLineDate: Date()), reducer: BoardListCellStore())
  static var previews: some View {
    BoardListCell(store: listCellStore)
      .previewLayout(.sizeThatFits)
      .padding()
  }
}
