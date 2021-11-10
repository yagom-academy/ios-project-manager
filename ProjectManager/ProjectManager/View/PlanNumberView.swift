//
//  PlanNumberView.swift
//  ProjectManager
//
//  Created by 이윤주 on 2021/11/10.
//

import SwiftUI

struct PlanNumberView: View {
    let numberOfPlans: Int
    
    var body: some View {
        ZStack {
            Circle()
                .fill(.black)
            
            Text("\(numberOfPlans)")
                .font(.system(size: 20))
                .foregroundColor(.white)
        }
        .frame(width: 30, height: 30)
    }
}

struct PlanNumberView_Previews: PreviewProvider {
    static var previews: some View {
        PlanNumberView(numberOfPlans: 3)
    }
}
