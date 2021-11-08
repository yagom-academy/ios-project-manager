//
//  MemoDetail.swift
//  ProjectManager
//
//  Created by JINHONG AN on 2021/10/28.
//

import SwiftUI

struct MemoDetail: View {
    @State var memo: MemoViewModel
    @EnvironmentObject var viewModel: MemoListViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    HStack {
                        leftButton
                        Spacer()
                        Text("TODO")
                        Spacer()
                        rightButton
                    }
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    VStack {
                        TextField("Title", text: $memo.memoTitle)
                            .padding()
                            .background(Color.white.shadow(color: .gray, radius: 3, x: 1, y: 4))
                        DatePicker(selection: $memo.memoDate, label: {})
                            .datePickerStyle(.wheel)
                            .labelsHidden()
                        TextEditor(text: $memo.memoDescription)
                            .background(Color.white.shadow(color: .gray, radius: 3, x: 1, y: 4))
                            .frame(height: geometry.size.height * 0.65)
                            .onChange(of: memo.memoDescription, perform: {
                                memo.memoDescription = String($0.prefix(1000))
                            })
                    }
                    .disabled(!viewModel.isDetailViewEditable)
                    .padding()
                }
            }
        }
    }
    
    var rightButton: some View {
        return Button {
            viewModel.didTouchUpDoneButton(memo)
        } label: {
            Text("Done")
        }
    }
    
    var leftButton: some View {
        return Button {
            viewModel.didTouchUpDetailViewLeftButton()
        } label: {
            Text(viewModel.detailViewLeftButtonTitle)
        }
    }
}

struct MemoDetail_Previews: PreviewProvider {
    static var previews: some View {
        MemoDetail(memo: MemoViewModel())
    }
}
