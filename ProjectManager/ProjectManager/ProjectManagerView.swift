//
//  ContentView.swift
//  ProjectManager
//
//  Created by 오승기 on 2021/10/27.
//

import SwiftUI

struct ProjectManagerView: View {
    var body: some View {
        VStack {
            ProjectManagerHeader()
            HStack{
                TodoList()
                TodoList()
                TodoList()
            }
        }.background(Color(UIColor.systemGray5))
            .edgesIgnoringSafeArea(.all)
    }
}

struct ProjectManagerHeader: View {
    var body: some View {
        HStack {
            Spacer()
            Text("Project Manager")
                .foregroundColor(.black)
                .bold()
                .font(.title3)
                .padding()
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "plus")
            }.padding()
        }
    }
}

struct ProjectManagerView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectManagerView()
    }
}
