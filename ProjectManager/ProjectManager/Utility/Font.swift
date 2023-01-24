//
//  Font.swift
//  ProjectManager
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

struct TextFontModifier: ViewModifier {
  var userFont: Font
  
  func body(content: Content) -> some View {
    content
      .font(userFont)
  }
}

extension View {
  func textFont(
    size: CGFloat,
    weight: Font.Weight = .regular
  ) -> some View {
    modifier(TextFontModifier(userFont: .system(size: size, weight: weight)))
  }
}
