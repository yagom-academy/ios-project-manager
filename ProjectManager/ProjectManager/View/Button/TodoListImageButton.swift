//
//  TodoListImageButton.swift
//  ProjectManager
//
//  Created by yun on 2021/11/04.
//

import SwiftUI

struct TodoListImageButton: View {
    let imageName: String
    
    var body: some View {
        Image(systemName: imageName)
    }
}
