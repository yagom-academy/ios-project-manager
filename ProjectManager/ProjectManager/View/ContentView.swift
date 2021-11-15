//
//  ContentView.swift
//  ProjectManager
//
//  Created by 이윤주 on 2021/10/27.
//

import SwiftUI

struct ContentView: View {
    let planStates = Plan.State.allCases
    @StateObject var viewModel: ProjectPlanViewModel
    @State var showsAddView = false
    
    var body: some View {
        NavigationView {
            HStack {
                ForEach(planStates, id: \.self) { planState in
                    PlanListView(projectState: planState.description,
                                 viewModel: viewModel,
                                 showsAddView: self.$showsAddView)
                }
            }
            .padding(0.2)
            .navigationTitle("Project Manager")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    plusButton
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: $showsAddView) {
            EditModalView(plan: nil,
                          editType: .add,
                          showsAddView: $showsAddView,
                          viewModel: viewModel)
        }
    }
}

extension ContentView {
    private var plusButton: some View {
        Button() {
            self.showsAddView.toggle()
        } label: {
            Image(systemName: "plus")
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
