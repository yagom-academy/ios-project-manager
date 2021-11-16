//
//  ProjectList.swift
//  ProjectManager
//
//  Created by 홍정아 on 2021/11/02.
//

import SwiftUI

struct ProjectList: View {
    @ObservedObject var viewModel: ListViewModel

    var body: some View {
        List {
            Section(header: header) {
                ForEach(viewModel.projects) { project in
                    ProjectRow(viewModel: viewModel.projectViewModel(project))
                        .fixedSize(horizontal: false, vertical: true)
                }
                .onDelete(perform: { indexSet in
                    viewModel.delete(at: indexSet.first)
                })
            }
        }
        .listStyle(GroupedListStyle())
        .background(Color(.systemGray5))
        
    }
    
    var header: some View {
        HStack {
            Text(viewModel.header)
                        .foregroundColor(.primary)
                        .font(.title)
            Image(systemName: "\(viewModel.count).circle.fill")
                .font(.title2)
                .foregroundColor(.black)
        }
    }
}

//struct ProjectList_Previews: PreviewProvider {
//    static var previews: some View {
//        ProjectList(viewModel: ProjectManagerViewModel(), status: .todo)
//            .previewLayout(.fixed(width: 1136/3, height: 820))
//    }
//}
