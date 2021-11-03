//
//  DetailPlanView.swift
//  ProjectManager
//
//  Created by 이윤주 on 2021/11/02.
//

import SwiftUI

struct DetailPlanView: View {
    let plan: ProjectToDoList.Plan
    
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
    }
}

struct DetailPlanView_Previews: PreviewProvider {
    static var previews: some View {
        DetailPlanView(plan: DummyData().data[0])
    }
}
