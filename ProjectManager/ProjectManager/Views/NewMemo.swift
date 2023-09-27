//
//  NewMemo.swift
//  ProjectManager
//
//  Created by Mary & Dasan on 2023/09/27.
//

import SwiftUI

struct NewMemo: View {
    @EnvironmentObject var modelData: ModelData
    @State private var memo: Memo = Memo.newMemo
        
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
                            TextField("Title", text: $memo.title)
                                .padding(20)
                        )
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                    
                    DatePicker("deadline", selection: $memo.deadline, displayedComponents: .date)
                        .labelsHidden()
                        .datePickerStyle(.wheel)
                    
                    Rectangle()
                        .foregroundColor(.white)
                        .shadow(radius: 5, x: 0, y: 5)
                        .overlay(
                            TextEditor(text: $memo.body)
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
                            Text("Cancel")
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

struct NewMemo_Previews: PreviewProvider {
    static var previews: some View {
        NewMemo()
    }
}
