//
//  DoneView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/06.
//

import SwiftUI

struct DoneView: View {
    var body: some View {
        HStack {
            Text("DONE")
                .font(.largeTitle)
                .foregroundColor(.black)
            ZStack {
            Circle()
                .frame(width: 25, height: 25)
                Text("5")
                    .foregroundColor(.white)
                    .font(.title2)
            }
        }.foregroundColor(.black)
    }
}

struct DoneView_Previews: PreviewProvider {
    static var previews: some View {
        DoneView().previewLayout(.sizeThatFits)
    }
}
