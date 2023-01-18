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
        .padding()
        
        Spacer()
      }
      .background(Color.secondaryBackground)
      .cornerRadius(20)
      .contextMenu {
        if let status = viewStore.status {
          contextMenuTopButton(viewStore: viewStore, status: status)
          contextMenuBottomButton(viewStore: viewStore, status: status)
        }
      }
    }
  }
}


func contextMenuTopButton(
  viewStore: ViewStore<BoardListCellStore.State, BoardListCellStore.Action>,
  status: ProjectState
) -> some View {
  var topButtonTitle: String = ""
  
  switch status {
  case .todo:
    topButtonTitle = "Move to DOING"
    
    return Button(topButtonTitle) {
      viewStore.send(.didChangeState(.doing))
    }
    
  case .doing, .done:
    topButtonTitle = "Move to TODO"
    
    return Button(topButtonTitle) {
      viewStore.send(.didChangeState(.todo))
    }
  }
}


func contextMenuBottomButton(
  viewStore: ViewStore<BoardListCellStore.State, BoardListCellStore.Action>,
  status: ProjectState
) -> some View {
  var bottomButtonTitle: String = ""
  
  switch status {
  case .todo, .doing:
    bottomButtonTitle = "Move to DONE"
    
    return Button(bottomButtonTitle) {
      viewStore.send(.didChangeState(.done))
    }
    
  case .done:
    bottomButtonTitle = "Move to DOING"
    
    return Button(bottomButtonTitle) {
      viewStore.send(.didChangeState(.doing))
    }
  }
}

struct BoardListCell_Previews:PreviewProvider {
  static let listCellStore = Store(
    initialState: BoardListCellStore.State( id: UUID(), project: Project(title: "Example", date: 8000000000, description: "ExampleExampleExampleExampleExampleExampleExampleExample"), detailState: nil),
    reducer: BoardListCellStore()
  )
  static var previews: some View {
    BoardListCell(store: listCellStore)
      .previewLayout(.sizeThatFits)
      .previewInterfaceOrientation(.landscapeLeft)
  }
}
