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
            .foregroundColor(.gray.opacity(0.1))
            .cornerRadius(20)
    }
}

struct TaskCellBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCellBackgroundView()
    }
}
