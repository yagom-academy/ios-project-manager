//
//  MainView.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/10/31.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = ProjectLists()
    var body: some View {
        HStack {
            List(self.viewModel.jobs) {
                if $0.state == .ToDo {
                    EventView(title: $0.title, description: $0.description, date: "\($0.date)")
                }
            }
            List(self.viewModel.jobs) {
                if $0.state == .Doing {
                    EventView(title: $0.title, description: $0.description, date: "\($0.date)")
                }
            }
            
            List(self.viewModel.jobs) {
                if $0.state == .Done {
                    EventView(title: $0.title, description: $0.description, date: "\($0.date)")
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
