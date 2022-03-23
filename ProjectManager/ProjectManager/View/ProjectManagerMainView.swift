//
//  ProjectManagerMainView.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/02/28.
//

import SwiftUI

struct ProjectManagerMainView: View {
    
    @EnvironmentObject private var viewModel: ProjectManagerViewModel
    
    @State private var isShowDetailSheet = false
    @State private var isShowHistoryPopover = false
    @State private var isShowAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    ForEach(TaskStatus.allCases) { status in
                        TaskListContainerView(taskType: status, isShowAlert: $isShowAlert)
                    }
                }
                if viewModel.isLostConnection {
                    Text("Network Connection Lost")
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .navigationTitle("Project Manager")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { isShowHistoryPopover.toggle() }) {
                        Text("History")
                    }
                    .popover(isPresented: $isShowHistoryPopover) {
                        Text("Hello World")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isShowDetailSheet.toggle() }) {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $isShowDetailSheet, onDismiss: nil) {
                        TaskFormCreateSheetView(isShowSheet: $isShowDetailSheet)
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
    
}
