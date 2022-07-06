//
//  CreateView.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/06.
//

import SwiftUI

struct CreateView: View {
  @State var title: String
  @State var date: Date
  @State var content: String
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
    var body: some View {
      VStack {
        HStack {
          Button(
            action: {
              self.presentationMode.wrappedValue.dismiss()
          }, label: {
            Text("Cancel")
          })
          .padding()
          Spacer()
          Text("TODO")
            .font(.body)
            .fontWeight(.bold)
          Spacer()
          Button(
            action: {
              self.presentationMode.wrappedValue.dismiss()
          }, label: {
            Text("Done")
          })
          .padding()
        }
        .background(Color(UIColor.systemGray5))
        
        VStack {
          ZStack {
            Rectangle()
              .fill(.white)
              .shadow(color: .gray, radius: 3, x: 0, y: 1)
              .frame(height: 30)
            TextField("title", text: $title)
              .padding(.leading)
          }
          
          DatePicker("", selection: $date)
            .datePickerStyle(.wheel)
            .labelsHidden()
          TextEditor(text: $content)
            .shadow(color: .gray, radius: 3, x: 0, y: 1)
        }
        .padding()
      }
      
    }
}
