//
//  MemoDetail.swift
//  ProjectManager
//
//  Created by JINHONG AN on 2021/10/28.
//

import SwiftUI

struct MemoDetail: View {
    @State var memo: Memo
    @Binding var isDetailViewPresented: Bool
    @EnvironmentObject var viewModel: MemoViewModel
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    
                } label: {
                    Text("Edit")
                }
                Spacer()
                Text("TODO")
                Spacer()
                Button {
                    viewModel.add(memo)
                    isDetailViewPresented = false
                } label: {
                    Text("Done")
                }
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            VStack {
                TextField("Title", text: $memo.title)
                    .padding()
                    .background(Color.white.shadow(color: .gray, radius: 3, x: 1, y: 4))
                DatePicker(selection: $memo.date, label: {})
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                TextEditor(text: $memo.description)
                    .background(Color.white.shadow(color: .gray, radius: 3, x: 1, y: 4))
            }
            .padding()
        }
    }
}

struct MemoDetail_Previews: PreviewProvider {
    static var previews: some View {
        MemoDetail(memo: Memo(), isDetailViewPresented: .constant(true))
    }
}
