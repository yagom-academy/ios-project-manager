//
//  PlanListView.swift
//  ProjectManager
//
//  Created by 이윤주 on 2021/11/02.
//

import SwiftUI

struct PlanListView: View {
    let projectState: String
    @ObservedObject var viewModel: ProjectPlanViewModel
    @Binding var showsAddView: Bool
    
    var body: some View {
        List {
            Section {
                ForEach(viewModel.plans) { plan in
                    if plan.state.description == projectState {
                        DetailPlanView(plan: plan, viewModel: viewModel)
                    }
                }
                .onDelete { indexSet in
                    viewModel.delete(at: indexSet)
                }
            } header: {
                HStack {
                    Text(projectState)
                        .foregroundColor(.black)
                        .font(.largeTitle)
                    PlanNumberView(numberOfPlans: viewModel.number(of: projectState))
                }
            }
        }
        .listStyle(.grouped)
    }
}

struct PlanListView_Previews: PreviewProvider {
    static var previews: some View {
        PlanListView(projectState: "TODO",
                     viewModel: ProjectPlanViewModel(),
                     showsAddView: .constant(true))
    }
}
