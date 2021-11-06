//
//  MainView.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/10/31.
//

import SwiftUI

struct MainView: View {
    //@ObservedObject var mainViewModel: T
    //@ObservedObject var detailViewModel: DetailViewModel
    var body: some View {
        NavigationView {
            HStack {
//                EventListView(state: .ToDo, eventListviewModels: mainViewModel)
//                EventListView(state: .Done, eventListviewModels: mainViewModel)
//                EventListView(state: .Doing, eventListviewModels: mainViewModel)
            }
        }.navigationViewStyle(.stack)
    }
}
//            HStack {
//                VStack {
//                    Section(header: Text("ToDo")
//                                .font(.title)) {
//                    }
//                    EventListView(state: .ToDo)
//                        .listStyle(.grouped)
//                }
//
//                VStack {
//                    Section(header: Text("Doing")
//                                .font(.title)) {
//                    }
//                    EventListView(state: .Doing)
//                        .listStyle(.grouped)
//                }
//
//                VStack {
//                    Section(header: Text("Done")
//                                .font(.title)) {
//                    }
//                    EventListView(state: .Done)
//                        .listStyle(.grouped)
//                    }
//            }
//            .navigationBarTitle("프로젝트 관리")
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar(content: {
//                AddEventButton()
//            })
//        }.navigationViewStyle(.stack)
//    }
//}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView(mainViewModel: ProjectManager(isOnTest: true))
//    }
//}
