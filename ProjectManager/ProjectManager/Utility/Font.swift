//
//  Font.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

struct TitleTextModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.system(size: 28, weight: .bold))
  }
}



extension View {
  func customTitleStyle() -> some View {
    modifier(TitleTextModifier())
  }
}
