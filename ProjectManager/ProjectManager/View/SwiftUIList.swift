//
//  SwiftUIList.swift
//  ProjectManager
//
//  Created by kaki, 릴라 on 2023/05/17.
//

import SwiftUI

struct SwiftUIList: View {
    let viewModel: TodoViewModel
    let formCase: Case
    
    var body: some View {
    
        List {
            Section {
                switch formCase {
                case .TODO:
                    ForEach(viewModel.doingList) { model in
                        CustomFormRow(model: model)
                    }
                    .onDelete { indexSet in
                        viewModel.delete(cases: .TODO, at: indexSet)
                    }
                    .listRowInsets(EdgeInsets(top: 20, leading: 10, bottom: 10, trailing: 10))
                    .listRowBackground(
                        Rectangle()
                            .fill(.white)
                            .padding(.top, 10)
                    )
                case .DOING:
                    ForEach(viewModel.doingList) { model in
                        CustomFormRow(model: model)
                    }
                    .onDelete { indexSet in
                        viewModel.delete(cases: .DOING, at: indexSet)
                    }
                    .listRowInsets(EdgeInsets(top: 20, leading: 10, bottom: 10, trailing: 10))
                    .listRowBackground(
                        Rectangle()
                            .fill(.white)
                            .padding(.top, 10)
                    )
                case .DONE:
                    ForEach(viewModel.doingList) { model in
                        CustomFormRow(model: model)
                    }
                    .onDelete { indexSet in
                        viewModel.delete(cases: .DONE, at: indexSet)
                    }
                    .listRowInsets(EdgeInsets(top: 20, leading: 10, bottom: 10, trailing: 10))
                    .listRowBackground(
                        Rectangle()
                            .fill(.white)
                            .padding(.top, 10)
                    )
                }
                
            } header: {
                Text(formCase.rawValue)
                    .font(.title)
                    .foregroundColor(.black)
                    .fontWeight(.light)
            }
        }
        
        .listStyle(.grouped)
    }
}

struct SwiftUIList_Previews: PreviewProvider {

    static var previews: some View {
        SwiftUIList(viewModel: TodoViewModel(), formCase: .DOING)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
