//
//  ListView.swift
//  ProjectManager
//
//  Created by 이예원 on 2021/11/03.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var listViewModel: ProjectManagerViewModel
    @State var isModalShowed: Bool = false
    @State var taskStatus: TaskStatus
    @State private var selectedRow: ProjectModel?
    var listStatus: [ProjectModel]
    
    var body: some View {
        VStack(alignment: .leading) {
            ListHeaderView(taskStatus: taskStatus, listStatus: listStatus)
            Divider()
            List {
                ForEach(listStatus) { item in
                    ListDetailRow(project: item)
                        .onTapGesture {
                            isModalShowed.toggle()
                            self.selectedRow = item
                    }
                }
                .onDelete(perform: listViewModel.deleteItem)
            }
            .sheet(item: self.$selectedRow, content: { selectedRow in
                ModalView(projectModel: selectedRow, isModalPresented: $isModalShowed, status: .edit)
            })
        }
        
        .background(Color("backgroundGray"))
    }
}

