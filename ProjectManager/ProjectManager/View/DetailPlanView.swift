//
//  DetailPlanView.swift
//  ProjectManager
//
//  Created by 이윤주 on 2021/11/02.
//

import SwiftUI

struct DetailPlanView: View {
    var plan: ProjectToDoList.Plan
    @State var showsPopOverView = false
    @State var showsEditView: Bool = false
    @ObservedObject var viewModel: ProjectPlanViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(plan.title)
                .font(.title3)
            Text(plan.description)
                .foregroundColor(.gray)
            Text(plan.deadline.description)
                .padding(.top, 1.0)
                .font(.footnote)
        }
        .onTapGesture {
            self.showsEditView.toggle()
        }
        .sheet(isPresented: $showsEditView) {
            AddPlanView(plan: plan, editType: .edit, showsAddView: $showsEditView, viewModel: viewModel)
        }
        .onLongPressGesture(perform: {
            self.showsPopOverView.toggle()
        })
        .popover(isPresented: $showsPopOverView) {
            PopOverView(plan: plan, viewModel: viewModel)
        }
    }
}

//struct DetailPlanView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailPlanView(plan: DummyData().data[0])
//    }
//}
