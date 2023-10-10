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
            .frame(height: 1.5)
            .foregroundColor(ColorSet.border)
    }
}

struct HorizontalDivider_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalDivider()
    }
}
