//
//  ListRowView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/06.
//

import SwiftUI

struct ListRowView: View {
  let taskTitle: String
  let taskBody: String
  let taskDate: Date
  let isOverdate: Bool
  @ObservedObject private(set) var listRowViewModel: ListRowViewModel
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(taskTitle)
        .foregroundColor(.black)
      Text(taskBody)
        .foregroundColor(.gray)
      checkOverdate()
    }
  }
  
  func checkOverdate() -> some View {
    if isOverdate {
      return Text(taskDate.convertDateToString)
  private func checkOverdate() -> some View {
        .foregroundColor(.red)
    } else {
      return Text(taskDate.convertDateToString)
        .foregroundColor(.black)
    }
  }
}

struct ListRowView_Previews: PreviewProvider {
  static var previews: some View {
    ListRowView(taskTitle: "title",
                taskBody: "body",
                taskDate: Date(),
                isOverdate: true)
      .previewLayout(.sizeThatFits)
  }
}
