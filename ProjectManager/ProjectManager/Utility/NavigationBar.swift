//
//  NavigationTitle.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

// Custom NavigationTitleView
struct NavigationTitleView: View {
  var title: String
  
  var trailingName: String? = "plus"
  var trailingAction: (() -> Void)? = nil
  
  var leadingName: String?
  var leadingAction: (() -> Void)? = nil
  
  var body: some View {
    ZStack {
      HStack {
        Spacer()
        
        Text(title)
          .customTitleStyle()
        
        Spacer()
      }
      .padding(.bottom)
      
      if let trailingName = trailingName, let trailingAction = trailingAction {
        HStack {
          Spacer()
          
          Button {
            trailingAction()
          } label: {
            Image(systemName: trailingName)
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
  }
}
