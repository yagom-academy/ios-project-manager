//
//  MemoDetail.swift
//  ProjectManager
//
//  Created by JINHONG AN on 2021/10/28.
//

import SwiftUI

enum AccessMode {
    case add
    case read
    case write
    
    var isEditable: Bool {
        switch self {
        case .add, .write:
            return true
        case .read:
            return false
        }
    }
}

struct MemoDetail: View {
    @State var memo: Memo
    @Binding var isDetailViewPresented: Bool
    @EnvironmentObject var viewModel: MemoListViewModel
    @State var accessMode: AccessMode
    
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
                        TextField("Title", text: $memo.title)
                            .padding()
                            .background(Color.white.shadow(color: .gray, radius: 3, x: 1, y: 4))
                        DatePicker(selection: $memo.date, label: {})
                            .datePickerStyle(.wheel)
                            .labelsHidden()
                        TextEditor(text: $memo.description)
                            .background(Color.white.shadow(color: .gray, radius: 3, x: 1, y: 4))
                            .frame(height: geometry.size.height * 0.65)
                            .onChange(of: memo.description, perform: {
                                memo.description = String($0.prefix(1000))
                            })
                    }
                    .disabled(!accessMode.isEditable)
                    .padding()
                }
            }
        }
    }
    
    var rightButton: some View {
        return Button {
            switch accessMode {
            case .add:
                viewModel.add(memo)
            case .read:
                break
            case .write:
                viewModel.modify(memo)
            }
            isDetailViewPresented = false
        } label: {
            Text("Done")
        }
    }
    
    var leftButton: some View {
        switch accessMode {
        case .add, .write:
            return Button {
                isDetailViewPresented = false
            } label: {
                Text("Cancel")
            }
        case .read:
            return Button {
                accessMode = .write
            } label: {
                Text("Edit")
            }
        }
    }
}

struct MemoDetail_Previews: PreviewProvider {
    static var previews: some View {
        MemoDetail(memo: Memo(), isDetailViewPresented: .constant(true), accessMode: .read)
    }
}
