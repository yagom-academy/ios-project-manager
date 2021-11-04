//
//  MemoPopover.swift
//  ProjectManager
//
//  Created by Kim Do hyung on 2021/11/03.
//

import SwiftUI

struct MemoPopover: View {
    var body: some View {
        VStack(spacing: 10) {
            Button {
                
            } label: {
                Text("Move to")
                    .font(.title3)
            }
            .padding()
            .background(Color.white)

            Button {
                
            } label: {
                Text("Move to")
                    .font(.title3)
            }
            .padding()
            .background(Color.white)
        }
        .padding()
        .background(Color(UIColor.systemGray6))
    }
}

struct MemoPopover_Previews: PreviewProvider {
    static var previews: some View {
        MemoPopover()
    }
}
