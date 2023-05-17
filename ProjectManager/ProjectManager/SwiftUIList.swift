//
//  SwiftUIList.swift
//  ProjectManager
//
//  Created by kaki, 릴라 on 2023/05/17.
//

import SwiftUI

struct SwiftUIList: View {
    let formCase: Case
    let models: [Model]
    
    var body: some View {
        List {
            Section {
                ForEach(models) { model in
                    CustomFormRow(model: model)
                }
                .listRowSeparator(.hidden)
                .listRowBackground(
                    Rectangle()
                        .fill(.white)
                        .padding(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
                )
            } header: {
                Text(formCase.rawValue)
                    .font(.title)
                    .foregroundColor(.black)
                    .fontWeight(.light)
            }
        }
        .listStyle(.grouped)
    }
}

struct SwiftUIList_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIList(formCase: .TODO, models: [Model(title: "오늘의 할일 찾기", body: "내가 가는 이길이 어디로 가는지 어디로 날 데려가는지 그곳은 어딘지 알 수 없지만 알 수 없지만 알 수 없지만 오늘도 난 걸어가고 있네 사람들은 길이 다 정해져 있다고 하지만", date: "2019. 1. 5."), Model(title: "라자냐 재료사러 가기", body: "프로젝트 회고를 작성하면 내가 이번 프로젝트에서 무엇을 놓쳤는지 명확히 알 수 있어요.", date: "2019. 1. 5."), Model(title: "책상정리", body: "집중이 안될땐 역시나 책상정리", date: "2019. 1. 5.")])
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
