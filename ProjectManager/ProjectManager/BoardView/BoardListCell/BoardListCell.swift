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
        Text(viewStore.project.title)
          .bold()
          .lineLimit(1)
          .font(.title2)
        
        Text(viewStore.project.description)
          .lineLimit(3)
          .font(.system(.body))
        
        Text(Date(timeIntervalSince1970: Double(viewStore.project.date)).description)
          .font(.caption)
      }
      .padding()
      .background(Color.secondaryBackground)
      .cornerRadius(15)
    }
  }
}

struct BoardListCell_Previews:PreviewProvider {
  static let listCellStore = Store(
    initialState: BoardListCellStore.State(id: UUID(), project: Project(title: "Example", date: 8000000000, description: "ExampleExampleExampleExampleExampleExampleExampleExample")),
    reducer: BoardListCellStore()
  )
  static var previews: some View {
    BoardListCell(store: listCellStore)
      .previewLayout(.sizeThatFits)
      .padding()
  }
}
