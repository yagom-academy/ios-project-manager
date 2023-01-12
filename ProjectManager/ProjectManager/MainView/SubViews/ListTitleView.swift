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
      Text(title)
        .font(.title2)
      
      Text("\(count)")
        .font(.title3)
        .foregroundColor(.white)
        .padding(10)
        .background(Circle())
      
      Spacer()
    }
    .padding()
  }
}

struct ListTitleView_Preview: PreviewProvider {
  static var previews: some View {
    ListTitleView(title: "TODO", count: 5)
      .previewLayout(.sizeThatFits)
      .preferredColorScheme(.light)
    
    ListTitleView(title: "TODO", count: 5)
      .previewLayout(.sizeThatFits)
      .preferredColorScheme(.dark)
  }
}
