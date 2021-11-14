//
//  MemoPopover.swift
//  ProjectManager
//
//  Created by Kim Do hyung on 2021/11/03.
//

import SwiftUI

struct MemoPopover: View {
    @EnvironmentObject var viewModel: MemoListViewModel
    @Binding var isPopoverShown: Bool
    let selectedMemo: MemoViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(selectedMemo.filterOutState(), id: \.self) { state in
                Button {
                    viewModel.didTouchUpPopoverButton(selectedMemo, newState: state)
                    isPopoverShown = false
                } label: {
                    Text("Move to \(state.description)")
                        .font(.title3)
                }
                .padding()
                .background(Color.white)
            }
        }
        .padding()
        .background(Color(UIColor.systemGray6))
    }
}

struct MemoPopover_Previews: PreviewProvider {
    static var previews: some View {
        MemoPopover(isPopoverShown: .constant(true), selectedMemo: MemoViewModel())
    }
}
