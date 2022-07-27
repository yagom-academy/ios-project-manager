//
//  ContentView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/05.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var contentViewModel: ContentViewModel
  
  var body: some View {
    NavigationView {
      HStack {
        // TODO
        ListView(listViewModel: ListViewModel(withService: contentViewModel.service, taskType: .todo))
        // DOING
        ListView(listViewModel: ListViewModel(withService: contentViewModel.service, taskType: .doing))
        // DONE
        ListView(listViewModel: ListViewModel(withService: contentViewModel.service, taskType: .done))
      }
        .background(.gray)
        .navigationTitle("Project Manager")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarColor(.systemGray5)
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: {
              contentViewModel.toggleShowingSheet()
            }) {
              Image(systemName: "plus")
                .imageScale(.large)
            }.sheet(isPresented: $contentViewModel.isShowingSheet) {
              RegisterView(registerViewModel: RegisterViewModel(withService: contentViewModel.service))
            }
          }
          ToolbarItem(placement: .navigationBarLeading) {
            Button(action: {
              contentViewModel.historyButtonTapped()
            }) {
              Text("History")
            }.popover(isPresented: $contentViewModel.isShowingHistory) {
              HistoryView(historyViewModel: HistoryViewModel(withService: contentViewModel.service))
            }
          }
        }
    }
    .navigationViewStyle(.stack)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(contentViewModel: ContentViewModel(withService: TaskManagementService()))
      .previewInterfaceOrientation(.landscapeLeft)
  }
}
