//
//  TodoListCell.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/06.
//

import SwiftUI

struct CellContentView: View {
  @ObservedObject var viewModel: CellContentViewModel
  
  init(viewModel: CellContentViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    ZStack {
      Rectangle()
        .fill(.white)
        .shadow(color: .gray, radius: 1, x: 0, y: 1)
      
      HStack {
        VStack(alignment: .leading) {
          Text(viewModel.todo.title)
              .font(.title)
              .lineLimit(1)
              .truncationMode(.tail)
            Text(viewModel.todo.content)
              .font(.body)
              .foregroundColor(.gray)
              .lineLimit(3)
              .truncationMode(.tail)
            Text(viewModel.todo.date.toString())
              .font(.body)
              .lineLimit(1)
              .foregroundColor(viewModel.isOverDate ? .red : .black )
        }
        .padding()
        Spacer()
      }
    }
  }
}
