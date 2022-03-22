//
//  ProjectManagerMainView.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/02/28.
//

import SwiftUI

struct ProjectManagerMainView: View {
    
    @EnvironmentObject private var viewModel: ProjectManagerViewModel
    
    @State private var isShowSheet = false
    @State private var isShowAlert = false
    
    var body: some View {
        NavigationView {
            HStack {
                ForEach(TaskStatus.allCases) { status in
                    TaskListContainerView(taskType: status, isShowAlert: $isShowAlert)
                }
            }
            .navigationTitle("Project Manager")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { }) {
                        Text("History")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isShowSheet.toggle() }) {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $isShowSheet, onDismiss: nil) {
                        TaskFormCreateSheetView(isShowSheet: $isShowSheet)
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
    
}
