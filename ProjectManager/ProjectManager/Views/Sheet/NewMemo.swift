//
//  NewMemo.swift
//  ProjectManager
//
//  Created by Mary & Dasan on 2023/09/27.
//

import SwiftUI

struct NewMemo: View {
    @EnvironmentObject private var modelData: ModelData
    @State private var memo: Memo = Memo.newMemo
        
    var body: some View {
        NavigationView {
            VStack {
                TitleTextField(content: $memo.title)
                DeadlinePicker(date: $memo.deadline)
                BodyTextField(content: $memo.body)
            }
            .sheetBackground()
            .navigationTitle(memo.category.description)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading:
                    Button {
                        
                    } label: {
                        Text("Cancel")
                    },
                trailing:
                    Button {
                        
                    } label: {
                        Text("Done")
                    }
            )
        }
        .navigationViewStyle(.stack)
    }
}

struct NewMemo_Previews: PreviewProvider {
    static var previews: some View {
        NewMemo()
    }
}
