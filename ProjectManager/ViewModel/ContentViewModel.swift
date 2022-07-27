//
//  ContentViewModel.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/20.
//

import SwiftUI

class ContentViewModel: ViewModelType {
  @Published var isShowingSheet = false
  @Published var isShowingHistory = false
  
  func plusButtonTapped() {
    isShowingSheet.toggle()
  }
  
  func historyButtonTapped() {
    isShowingHistory.toggle()
  }
}
