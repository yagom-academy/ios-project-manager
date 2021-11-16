//
//  ProjectRow.swift
//  ProjectManager
//
//  Created by 홍정아 on 2021/11/02.
//

import SwiftUI

struct ProjectRow: View {
    @ObservedObject var viewModel: ProjectViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(viewModel.title)
                    .font(.title2)
                    .lineLimit(1)
                Text(viewModel.content)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 5)
                    .lineLimit(3)
                Text(viewModel.dueDate)
                    .font(.callout)
                    .foregroundColor(viewModel.isExpired ? .red : .black)
            }
            Spacer()
        }
        .background(Color.white)
        .onTapGesture {
            viewModel.tapped.toggle()
        }
        .onLongPressGesture(perform: {
            viewModel.longPressed.toggle()
        })
        .sheet(isPresented: $viewModel.tapped, content: {
            ProjectDetail(viewModel: viewModel.detailViewModel)
        })
        .popover(isPresented: $viewModel.longPressed) {
            PopOver(viewModel: viewModel.popOverViewModel)
        }
    }
}

//struct ProjectRow_Previews: PreviewProvider {
//    static var previews: some View {
//        ProjectRow(id: UUID())
//            .previewLayout(.fixed(width: 300, height: 100))
//    }
//}
