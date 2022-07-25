//
//  CellView11.swift
//  ProjectManager
//
//  Created by song on 2022/07/24.
//

import SwiftUI

struct CellOperationView: View {
  @ObservedObject var viewModel: CellOperationViewModel
  
  init(viewModel: CellOperationViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    CellView(viewModel: viewModel.todoListCellViewModel)
      .onTapGesture(perform: {
        viewModel.pressedCell()
      })
      .onLongPressGesture(perform: {
        viewModel.LongPressed()
      })
      .sheet(isPresented: $viewModel.isShowEditView) {
        EditView(viewModel: viewModel.editViewModel)
      }
      .popover(isPresented: $viewModel.isShowModal) {
        PopOverView(viewModel: viewModel.popViewModel)
      }
      .onChange(of: viewModel.todo) { todo in
        viewModel.todoListCellViewModel.todo = todo
      }
  }
}
