//
//  HorizontalDivider.swift
//  ProjectManager
//
//  Created by Mary & Dasan on 2023/09/28.
//

import SwiftUI

struct HorizontalDivider: View {
    var body: some View {
        Rectangle()
            .fill(ColorSet.background)
            .frame(height: 10)
            .overlay(
                Rectangle()
                    .frame(width: nil, height: 3)
                    .foregroundColor(ColorSet.border),
                alignment: .top
            )
    }
}

struct HorizontalDivider_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalDivider()
    }
}
