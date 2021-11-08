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
    let selectedMemo: Memo
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(filterOutState(), id: \.self) { state in
                Button {
                    viewModel.moveColumn(memo: selectedMemo, to: state)
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
    
    private func filterOutState() -> [MemoState] {
        var states = MemoState.allCases
        states.remove(at: selectedMemo.status.indexValue)
        return states
    }
}

struct MemoPopover_Previews: PreviewProvider {
    static var previews: some View {
        MemoPopover(isPopoverShown: .constant(true), selectedMemo: Memo())
    }
}
