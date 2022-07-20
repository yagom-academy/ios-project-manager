//
//  CellViewModel.swift
//  ProjectManager
//
//  Created by marisol on 2022/07/20.
//

import SwiftUI

class CellViewModel: ObservableObject {
    @ObservedObject var allListViewModel = AllListViewModel()
    @State var isShowingSheet = false
    @State var isShowingPopover = false
    
    func toggleShowingSheet() {
        isShowingSheet.toggle()
    }
    
    func toggleShowingPopover() {
        isShowingPopover.toggle()
    }
}
