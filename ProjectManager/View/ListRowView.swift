//
//  ListRowView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/06.
//

import SwiftUI

struct ListRowView: View {
    var contentViewModel: ContentViewModel
    var cellIndex: Int
    
    var body: some View {
            VStack(alignment: .leading) {
                Text(contentViewModel.data.taskArray[cellIndex].title)
                    .foregroundColor(.black)
                Text(contentViewModel.data.taskArray[cellIndex].body)
                    .foregroundColor(.gray)
                Text(contentViewModel.data.taskArray[cellIndex].date.convertDateToString)
                    .foregroundColor(.black)
            }
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView(contentViewModel: ContentViewModel(), cellIndex: 0).previewLayout(.sizeThatFits)
    }
}
