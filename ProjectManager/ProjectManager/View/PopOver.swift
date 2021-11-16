//
//  PopUpMenu.swift
//  ProjectManager
//
//  Created by 홍정아 on 2021/11/05.
//

import SwiftUI

struct PopOver: View {
    @ObservedObject var viewModel: PopOverViewModel
    
    var body: some View {
        ZStack {
            Color(.systemGray5)
            VStack(spacing: 5) {
                ForEach(viewModel.popOverOptions, id: \.self) { popupStatus in
                    Text("Move to \(popupStatus.header)")
                        .foregroundColor(.accentColor)
                        .frame(width: 230, height: 40)
                        .background(Color.white)
                        .onTapGesture {
                            viewModel.update(popupStatus)
                        }
                }
            }
            .frame(width: 250, height: 105)
        }
    }
}

//struct PopUpMenu_Previews: PreviewProvider {
//    static var previews: some View {
//        PopUpMenu(id: UUID())
//            .previewLayout(.fixed(width: 250, height: 105))
//    }
//}
