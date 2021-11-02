//
//  PlanListView.swift
//  ProjectManager
//
//  Created by 이윤주 on 2021/11/02.
//

import SwiftUI

struct PlanListView: View {
    var body: some View {
        List {
            Section {
                DetailPlanView()
            } header: {
                Text("TODO")
                    .foregroundColor(.black)
                    .font(.largeTitle)
            }
        }
        .listStyle(.grouped)
    }
}

struct PlanListView_Previews: PreviewProvider {
    static var previews: some View {
        PlanListView()
    }
}
