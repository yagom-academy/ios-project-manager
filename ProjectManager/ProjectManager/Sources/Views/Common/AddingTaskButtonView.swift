//
//  AddingTaskButtonView.swift
//  ProjectManager
//
//  Created by minsson on 2022/09/16.
//

import SwiftUI

struct AddingTaskButtonView: View {
    
    var body: some View {
        
        Circle()
            .overlay(alignment: .bottomTrailing) {
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .padding()
            }
    }
}

struct AddingTaskButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddingTaskButtonView()
    }
}
