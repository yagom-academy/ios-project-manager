//
//  ListHeaderView.swift
//  ProjectManager
//
//  Created by 이예원 on 2021/11/09.
//

import SwiftUI

struct ListHeaderView: View {
    @State var taskStatus: TaskStatus
    var listStatus: [ProjectModel]

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(taskStatus.description)
                    .font(.title)
                    .padding([.top, .leading])
                
                Text("\(listStatus.count)")
                    .foregroundColor(.white)
                    .background(
                        Circle()
                            .foregroundColor(.black)
                            .frame(width: 30, height: 30)
                    )
                    .font(.title2)
                    .padding([.top, .leading])
            }
        }
    }
}
