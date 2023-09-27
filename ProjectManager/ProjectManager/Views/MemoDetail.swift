//
//  MemoDetail.swift
//  ProjectManager
//
//  Created by Mary & Dasan on 2023/09/26.
//

import SwiftUI

struct MemoDetail: View {
    @EnvironmentObject var modelData: ModelData
    var memo: Memo
    
    var memoIndex: Int {
        modelData.memos.firstIndex(where: { $0.id == memo.id })!
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                ColorSet.navigationBarBackground.edgesIgnoringSafeArea(.all)
                Color.white
                
                VStack {
                    Rectangle()
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .shadow(radius: 5, x: 0, y: 5)
                        .overlay(
                            TextField("Title", text: $modelData.memos[memoIndex].title)
                                .padding(20)
                        )
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                    
                    DatePicker("deadline", selection: $modelData.memos[memoIndex].deadline, displayedComponents: .date)
                        .labelsHidden()
                        .datePickerStyle(.wheel)
                    
                    Rectangle()
                        .foregroundColor(.white)
                        .shadow(radius: 5, x: 0, y: 5)
                        .overlay(
                            TextEditor(text: $modelData.memos[memoIndex].body)
                                .padding(20)
                        )
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                }
                .navigationTitle(memo.category.description)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(
                    leading:
                        Button {
                            
                        } label: {
                            Text("Edit")
                        },
                    trailing:
                        Button {
                            
                        } label: {
                            Text("Done")
                        }
                )
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct MemoDetail_Previews: PreviewProvider {
    static var previews: some View {
        MemoDetail(memo: ModelData().memos[0])
            .environmentObject(ModelData())
    }
}
