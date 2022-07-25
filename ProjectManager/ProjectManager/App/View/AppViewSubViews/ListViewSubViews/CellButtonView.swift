//
//  CellView11.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/24.
//

import SwiftUI

struct CellButtonView: View {
  @ObservedObject var viewModel: CellButtonViewModel
  
  init(viewModel: CellButtonViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    CellContentView(viewModel: viewModel.cellContentViewModel)
      .onTapGesture(perform: {
        viewModel.cellTapped()
      })
      .onLongPressGesture(perform: {
        viewModel.cellLongTapped()
      })
      .sheet(isPresented: $viewModel.isShowEditView) {
        EditView(viewModel: viewModel.editViewModel)
      }
      .popover(isPresented: $viewModel.isShowPopover) {
        PopOverView(viewModel: viewModel.popViewModel)
      }
      .onChange(of: viewModel.todo) { todo in
        viewModel.cellContentViewModel.todo = todo
      }
      
  }
}
