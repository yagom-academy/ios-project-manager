//
//  HeaderView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/22.
//
import SwiftUI

struct HeaderView: View {
  let title: String
  let numberOfTasks: Int
  
  var body: some View {
    HStack {
      Text(title)
        .font(.largeTitle)
        .foregroundColor(.black)
      ZStack {
        Circle()
          .frame(width: 25, height: 25)
        Text(String(numberOfTasks))
          .foregroundColor(.white)
          .font(.title2)
      }
    }.foregroundColor(.black)
  }
}

struct HeaderView_Previews: PreviewProvider {
  static var previews: some View {
    HeaderView(title: TaskType.todo.title, numberOfTasks: 1)
  }
}
