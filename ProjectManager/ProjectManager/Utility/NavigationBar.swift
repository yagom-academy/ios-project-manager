//
//  NavigationTitle.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

struct NavigationTitleView: View {
  var title: String
  
  var trailingImage: Image?
  var trailingAction: (() -> Void)? = nil
  
  var leadingImage: Image?
  var leadingAction: (() -> Void)? = nil
  
  var body: some View {
    ZStack {
      HStack {
        Spacer()
        
        Text(title)
          .foregroundColor(.accentColor)
          .customTitleStyle()
        
        Spacer()
      }
      .padding(.bottom)
      
      if let trailingImage = trailingImage,
         let trailingAction = trailingAction {
        HStack {
          Spacer()
          
          Button {
            trailingAction()
          } label: {
            trailingImage
              .customTitleStyle()
          }
        }
        .padding([.vertical, .trailing])
      }
      
      if let leadingImage = leadingImage,
         let leadingAction = leadingAction {
        HStack {
          Button {
            leadingAction()
          } label: {
            leadingImage
          }
          
          Spacer()
          
        }
        .padding()
      }
    }
    .background(Color.secondaryBackground)
  }
}
