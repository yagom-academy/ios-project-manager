//
//  PopoverEdit.swift
//  ProjectManager
//
//  Created by 이예원 on 2021/11/01.
//

import SwiftUI

struct EditPopover: View {
    @State private var date = Date()
    @State private var title = ""
    @State private var detail = ""

    
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
                HStack {
                    Button {
                        print()
                    } label: {
                        Text("Edit")
                            .font(.title3)
                            .padding(.leading)
                    }
                    Spacer()
                    Text("TODO")
                        .font(.title2)
                    Spacer()
                    Button {
                        isPresented = false
                    } label: {
                        Text("Done")
                            .font(.title3)
                            .padding(.trailing)
                    }
                }
                .padding(.bottom)
                .background(Color(white: 0.93))
    
            VStack {
                TextField("Title", text: $title)
                    .font(.title3)
                    .textFieldStyle(.roundedBorder)
                    .shadow(color: .gray, radius: 5)
                
                DatePicker("", selection: $date, displayedComponents: .date)
                    .labelsHidden()
                    .datePickerStyle(.wheel)
                    
                TextEditor(text: $detail)
                    .textFieldStyle(.roundedBorder)
                    .shadow(color: .gray, radius: 5)
            }
            .padding(/*@START_MENU_TOKEN@*/[.leading, .bottom, .trailing]/*@END_MENU_TOKEN@*/)
        }
    }
}

struct EditPopover_Previews: PreviewProvider {
    static var previews: some View {
        EditPopover(isPresented: .constant(false))
.previewInterfaceOrientation(.landscapeLeft)
    }
}
