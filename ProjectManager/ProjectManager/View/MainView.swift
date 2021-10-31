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
        NavigationView {
            HStack {
                Section {
                    List(viewModel.jobs) {
                        if $0.state == .ToDo {
                            EventView(title: $0.title, description: $0.description, date: "\($0.date)")
                        }
                    }
                }
                Section {
                      List(self.viewModel.jobs) {
                          if $0.state == .Doing {
                              EventView(title: $0.title, description: $0.description, date: "\($0.date)")
                          }
                      }
                }
                
                Section {
                    List(self.viewModel.jobs) {
                        if $0.state == .Done {
                            EventView(title: $0.title, description: $0.description, date: "\($0.date)")
                        }
                    }
                }
            }
            .navigationBarTitle(Text("프로젝트 관리").font(.title))
            .navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
