//
//  ListRowView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/06.
//

import SwiftUI

struct ListRowView: View {
    var contentViewModel: ContentViewModel
    
    var body: some View {
            VStack(alignment: .leading) {
                Text(contentViewModel.data.title)
                    .foregroundColor(.black)
                Text(contentViewModel.data.body)
                    .foregroundColor(.gray)
                Text(contentViewModel.data.dueDate.convertDateToString)
                    .foregroundColor(.black)
            }
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView(contentViewModel: ContentViewModel()).previewLayout(.sizeThatFits)
    }
}
