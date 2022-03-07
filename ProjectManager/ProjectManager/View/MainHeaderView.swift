//
//  MainHeaderView.swift
//  ProjectManager
//
//  Created by 예거 on 2022/03/08.
//

import SwiftUI

struct MainHeaderView: View {
    var body: some View {
        Section {
            HStack {
                Image(systemName: "plus")
                    .font(.title)
                    .padding(.leading, 30)
                    .hidden()
                Spacer()
                Text("Project Manager")
                    .font(.title3)
                    .bold()
                Spacer()
                Button {
                    print("💚 할일 추가 버튼 눌림!") // TODO: 할일 추가 화면 연결
                } label: {
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundColor(.blue)
                }
                .padding(.trailing, 30)
            }
        }
    }
}
