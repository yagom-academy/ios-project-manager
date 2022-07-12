//
//  HeaderView.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/06.
//

import SwiftUI

struct HeaderView: View {
  @ObservedObject var viewModel: AppViewModel
  @State var title: Todo.Status
  
  var body: some View {
    VStack {
      HStack {
        Text(title.rawValue)
          .font(.title)
        
        ZStack {
          Circle()
            .fill(.black)
            .frame(width: 30, height: 30)
          
          Text("\(viewModel.read(by: title).count)")
            .font(.title3)
            .foregroundColor(.white)
        }
        Spacer()
      }
      .padding(.leading, 10)
      .padding(.top, 20)
      
      Rectangle()
        .frame(height: 1)
        .foregroundColor(Color(UIColor.systemGray3))
    }
    .background(Color(UIColor.systemGray5))
  }
}
