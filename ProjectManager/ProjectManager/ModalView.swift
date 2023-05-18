//
//  ModalView.swift
//  ProjectManager
//
//  Created by 김성준 on 2023/05/18.
//

import SwiftUI

struct ModalView: View {
    @State var title: String = ""
    @State var date: Date = .init()
    @State var text: String = ""
    
    var body: some View {
        NavigationStack{
            VStack{
                TextField("Enter your Title", text: $title)
                    .padding(14)
                    .background(.white)
                    .border(.shadow(.drop(radius: 5)))
                DatePicker("ddd", selection: $date)
                    .datePickerStyle(.wheel).labelsHidden()
                TextEditor(text: $text)
                    .padding()
                    .foregroundColor(.black)
                    .font(.body)
            }
            .background(Color(UIColor.systemGray3))
            .navigationTitle("TODO")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Text("Done")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        
                    } label: {
                        Text("Cancel")
                    }
                }
                
            }
            

        }
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView()
    }
}
