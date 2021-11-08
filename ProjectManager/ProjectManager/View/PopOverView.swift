//
//  PopOverView.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/11/07.
//

import SwiftUI



struct PopOverView<T: ItemViewModelable>: View {
    
    @State var state: EventState
    var viewModel: T
    
    var body: some View {
        VStack {
            Button(state.popOverButtonState.0.rawValue) {
                self.viewModel.input.onChangeEventState(to: state.popOverButtonState.0)
            }
            Button(state.popOverButtonState.1.rawValue) {
                self.viewModel.input.onChangeEventState(to: state.popOverButtonState.1)
            }
        }
    }
}

