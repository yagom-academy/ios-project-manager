//
//  HeaderView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/22.
//
import SwiftUI

struct HeaderView: View {
    let allListViewModel: AllListViewModel
    let type: TaskType
    
    var body: some View {
        HStack {
            Text(type.title)
                .font(.largeTitle)
                .foregroundColor(.black)
            ZStack {
                Circle()
                    .frame(width: 25, height: 25)
                Text(String(allListViewModel.service.tasks.filter({ $0.type == self.type }).count))
                    .foregroundColor(.white)
                    .font(.title2)
            }
        }.foregroundColor(.black)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(allListViewModel: AllListViewModel(withService: TaskManagementService()), type: .todo)
    }
}
