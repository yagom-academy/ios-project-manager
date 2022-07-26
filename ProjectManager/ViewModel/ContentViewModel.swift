//
//  ContentViewModel.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/20.
//

import SwiftUI

class ContentViewModel: ViewModelType {
  @Published var isShowingSheet = false
  
  func toggleShowingSheet() {
    isShowingSheet.toggle()
  }
}
