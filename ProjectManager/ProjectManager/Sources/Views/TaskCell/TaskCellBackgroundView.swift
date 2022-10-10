//
//  TaskCellBackgroundView.swift
//  ProjectManager
//
//  Created by minsson on 2022/09/15.
//

import SwiftUI

struct TaskCellBackgroundView: View {
    
    var body: some View {
        Rectangle()
            .foregroundColor(Color(UIColor.secondarySystemBackground))
            .cornerRadius(20)
    }
}

struct TaskCellBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCellBackgroundView()
    }
}
