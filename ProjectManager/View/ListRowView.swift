//
//  ListRowView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/06.
//

import SwiftUI

struct ListRowView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("책상정리")
            Text("집중이 안될 때 역시나 책상정리").foregroundColor(.gray)
            Text("2021. 11. 6.")
        }
        .padding()
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView().previewLayout(.sizeThatFits)
    }
}
