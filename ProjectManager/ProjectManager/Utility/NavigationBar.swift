//
//  NavigationTitle.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

extension Image {
  static let plusImage: Image = Image(systemName: "plus")
}

// Custom NavigationTitleView
struct NavigationTitleView: View {
  var title: String
  
  var trailingImage: Image?
  var trailingAction: (() -> Void)? = nil
  
  var leadingName: String?
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
      
      if let trailingImage = trailingImage, let trailingAction = trailingAction {
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
      
      if let leadingName = leadingName, let leadingAction = leadingAction {
        HStack {
          Button {
            leadingAction()
          } label: {
            Image(systemName: leadingName)
          }
          
          Spacer()
          
        }
        .padding()
      }
    }
    .background(Color.secondaryBackground)
  }
}
