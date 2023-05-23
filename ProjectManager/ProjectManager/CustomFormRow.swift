//
//  CustomCell.swift
//  ProjectManager
//
//  Created by kaki, 릴라 on 2023/05/17.
//

import SwiftUI

struct CustomFormRow: View {
    let model: Todo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Text(model.title)
                .lineLimit(1)
            Text(model.body)
                .lineLimit(3)
                .foregroundColor(.secondary)
            Text(model.date)
        }
    }
}

struct CustomCell_Previews: PreviewProvider {
    static var previews: some View {
        CustomFormRow(model: Todo(title: "라자냐 재료사러 가기", body: "프로젝트 회고를 작성하면 내가 이번 프로젝트에서 무엇을 놓쳤는지 명확히 알 수 있어요.", date: "2019. 1. 5."))
    }
}
