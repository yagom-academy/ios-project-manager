//
//  DetailPlanView.swift
//  ProjectManager
//
//  Created by 이윤주 on 2021/11/02.
//

import SwiftUI

struct DetailPlanView: View {
    let plan: Plan
    @State var showsPopOverView = false
    @State var showsEditView: Bool = false
    @ObservedObject var viewModel: ProjectPlanViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            titleTextView
            descriptionTextView
            deadlineTextView
        }
        .onTapGesture {
            self.showsEditView.toggle()
        }
        .sheet(isPresented: $showsEditView) {
            EditModalView(plan: plan,
                          editType: .edit,
                          showsAddView: $showsEditView,
                          viewModel: viewModel)
        }
        .onLongPressGesture(perform: {
            self.showsPopOverView.toggle()
        })
        .popover(isPresented: $showsPopOverView) {
            PopOverView(plan: plan, viewModel: viewModel)
        }
    }
}

extension DetailPlanView {
    private var titleTextView: some View {
        Text(plan.title)
            .font(.title3)
            .lineLimit(1)
    }
    
    private var descriptionTextView: some View {
        Text(plan.description)
            .foregroundColor(.gray)
            .lineLimit(3)
    }
    
    private var deadlineTextView: some View {
        if viewModel.isOverdue(plan) {
            return Text(viewModel.format(date: plan.deadline))
                .foregroundColor(.red)
                .padding(.top, 1.0)
                .font(.footnote)
        } else {
            return Text(viewModel.format(date: plan.deadline))
                .padding(.top, 1.0)
                .font(.footnote)
        }
    }
}

struct DetailPlanView_Previews: PreviewProvider {
    static var previews: some View {
        DetailPlanView(plan: DummyData().data[0], viewModel: ProjectPlanViewModel())
    }
}
