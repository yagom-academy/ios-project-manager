//
//  DetailPlanView.swift
//  ProjectManager
//
//  Created by 이윤주 on 2021/11/02.
//

import SwiftUI

struct DetailPlanView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("마라탕먹기")
                .font(.title3)
            Text("마라탕 먹고싶다. 내일 마라탕 먹으러 가야지")
                .foregroundColor(.gray)
            Text("2021. 11. 3.")
                .padding(.top, 1.0)
                .font(.footnote)
        }
    }
}

struct DetailPlanView_Previews: PreviewProvider {
    static var previews: some View {
        DetailPlanView()
    }
}
