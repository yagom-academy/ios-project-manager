//
//  PopOverView.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/11/07.
//

import SwiftUI



struct PopOverView<T: ItemViewModelable>: View {
    @State var eventState: EventState
    @ObservedObject var viewModel: T
    
    var body: some View {
        VStack(spacing: 10) {
            Button(eventState.popOverButtonOptions.top.rawValue) {
                self.viewModel.input.onChangeEventState(to: eventState.popOverButtonOptions.top)
            }
            Button(eventState.popOverButtonOptions.bottom.rawValue) {
                self.viewModel.input.onChangeEventState(to: eventState.popOverButtonOptions.bottom)
            }
        }
        .padding()
        .background(Color.white)
    }
}

