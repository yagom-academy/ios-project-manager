//
//  TodoNavigationView.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/06.
//

import SwiftUI

struct TodoNavigationView: View {
  @State var isCreate: Bool = false
    var body: some View {
      HStack {
        Spacer()
        Text("Project Manager")
        .font(.title)
        Spacer()
        Button(
          action: {
            self.isCreate = true
        }, label: {
          Image(systemName: "plus")
        })
        .sheet(isPresented: self.$isCreate, content: {
          CreateView(title: "", date: Date(), content: "")
        })
        .padding()
      }
    }
}
