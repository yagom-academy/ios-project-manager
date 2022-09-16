//
//  SquareButtonView.swift
//  ProjectManager
//
//  Created by minsson on 2022/09/16.
//

import SwiftUI

struct SquareButtonView: View {
    
    var label: String
    var color: Color
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(label.uppercased())
                .foregroundColor(.white)
                .font(.title2)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(color)
                .cornerRadius(10)
        }
    }
}

struct SquareButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SquareButtonView(label: "버튼", color: Color.purple) {
        
        }
    }
}
