//
//  ListTitleView.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

struct ListTitleView: View {
  let title: String
  let count: Int
  
  var body: some View {
    HStack(alignment: .center) {
      Spacer()
      
      Text(title)
        .font(.system(size: 32, weight: .bold, design: .rounded))
        .foregroundColor(.accentColor)
      Spacer()
      
      if count.description.count <= 2 {
        Text("\(count)")
          .font(.system(size: 21, weight: .semibold, design: .rounded))
          .foregroundColor(.white)
          .padding(10)
          .background(Circle().foregroundColor(.accentColor))
      } else {
        Text("\(count)")
          .font(.system(size: 21, weight: .semibold, design: .rounded))
          .foregroundColor(.white)
          .padding(10)
          .background(Capsule().foregroundColor(.accentColor))
      }
    }
    .padding()
  }
}

struct ListTitleView_Preview: PreviewProvider {
  static var previews: some View {
    ListTitleView(title: "TODO", count: 10)
      .previewLayout(.sizeThatFits)
      .preferredColorScheme(.light)
    
    ListTitleView(title: "TODO", count: 5)
      .previewLayout(.sizeThatFits)
      .preferredColorScheme(.dark)
  }
}
