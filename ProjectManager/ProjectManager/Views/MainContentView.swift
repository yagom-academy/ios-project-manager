//
//  ContentView.swift
//  ProjectManager
//
//  Created by 이예원 on 2021/10/26.
//

import SwiftUI

struct MainContentView: View {
    @EnvironmentObject var listViewModel: ProjectManagerViewModel
    @State private var isPopoverPresented: Bool = false

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Project Manager")
                    .font(.title3)
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                Spacer()
                Button {
                    isPopoverPresented = true
                } label: {
                    Image(systemName: "plus")
                        .font(.largeTitle)
                }
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .sheet(isPresented: $isPopoverPresented) {
                    ModalView(projectModel: .init(title: "", description: "", date: Date()), isModalPresented: $isPopoverPresented, status: .add)
                }
            }
            .background(Color(white: 0.94))
            .font(.title)
            HStack {
                ListView(
                    isModalShowed: isPopoverPresented, taskStatus: .todo, listStatus: listViewModel.list[0])
                ListView(
                    isModalShowed: isPopoverPresented, taskStatus: .doing, listStatus: listViewModel.list[1])
                ListView(
                    isModalShowed: isPopoverPresented, taskStatus: .done, listStatus: listViewModel.list[2])
            }
            .background(Color(white: 0.8))
            .listStyle(PlainListStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
            .environmentObject(ProjectManagerViewModel())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
