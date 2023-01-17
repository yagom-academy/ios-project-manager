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
      HStack(spacing: 0) {
        VStack(alignment: .leading, spacing: 10) {
          Text(viewStore.project.title)
            .bold()
            .lineLimit(1)
            .font(.title2)
          
          Text(viewStore.project.description)
            .lineLimit(3)
            .font(.system(.body))
          
          Text(viewStore.project.date.convertedDateDescription)
            .font(.callout)
        }
        
        Spacer()
      }
      .padding()
      .background(Color.secondaryBackground)
      .cornerRadius(20)
      .contextMenu {
        // TODO: - 이동 메서드 추가
        Button("Move to Doing") {
          viewStore.send(.didChangeState(.doing))
        }
        
        Button("Move to Done") {
          viewStore.send(.didChangeState(.done))
        }
      }
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
      .previewInterfaceOrientation(.landscapeLeft)
      .padding()
  }
}
