//
//  HorizontalSpacing.swift
//  ProjectManager
//
//  Created by Mary & Dasan on 2023/10/02.
//

import SwiftUI

struct HorizontalSpacing: View {
    var body: some View {
        Rectangle()
            .fill(ColorSet.background)
            .frame(height: 8)
    }
}

struct HorizontalSpacing_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalSpacing()
    }
}
