//
//  ContentView.swift
//  ProjectManager
//
//  Created by 이윤주 on 2021/10/27.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ProjectPlanViewModel
    let planStates = ProjectToDoList.Plan.State.allCases
    @State var showsAddView = false
    
    var body: some View {
        NavigationView {
            HStack {
                ForEach(planStates, id: \.self) { planState in
                    PlanListView(viewModel: viewModel, projectState: planState.description)
                }
            }
            .padding(0.2)
            .navigationTitle("Project Manager")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button() {
                        self.showsAddView.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: $showsAddView) {
            AddPlanView(showsAddView: self.$showsAddView, viewModel: viewModel)
        }
    }
}

@available(iOS 15.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ProjectPlanViewModel())
            .previewInterfaceOrientation(.landscapeRight)
    }
}
