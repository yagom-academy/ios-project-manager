//
//  RegisterView.swift
//  ProjectManager
//
//  Created by Kiwon Song on 2022/09/15.
//

import SwiftUI

struct TodoContentView: View {
    @State var buttonType: String
    
    var body: some View {
        NavigationView {
            RegisterElementsView()
                .navigationTitle("TODO")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarColor(.systemGray5)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            print("Cancelbutton")
                        }, label: {
                            Text("Cancel")
                        })
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            print("buttonTapped")
                        }, label: {
                            Text(buttonType)
                        })
                    }
                }
        }
        .navigationViewStyle(.stack)
    }
}

struct RegisterElementsView: View {
    @State private var title = ""
    @State private var date = Date()
    @State private var text: String = "내용을 입력하세요."
    
    var body: some View {
        VStack {
            Spacer()
            
            TextField("제목", text: $title)
                .foregroundColor(Color.gray)
                .padding(.all)
                .background(
                    Color(UIColor.systemBackground)
                        .shadow(color: Color.primary.opacity(0.4), radius: 5, x: 0, y: 5)
                )
                .border(.gray)
                .padding(.leading)
                .padding(.trailing)
                .font(.title2)
            
            DatePicker("", selection: $date, displayedComponents: .date)
                .datePickerStyle(.wheel)
                .labelsHidden()
            
            TextEditor(text: $text)
                .border(.gray)
                .background(
                    Color(UIColor.systemBackground)
                        .shadow(color: Color.primary.opacity(0.4), radius: 5, x: 0, y: 5)
                )
                .padding(.all)
                .foregroundColor(Color.gray)
        }
    }
}

struct ResisterView_Previews: PreviewProvider {
    static var previews: some View {
        TodoContentView(buttonType: "Done")
    }
}
