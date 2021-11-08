//
//  ListRowView.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/11/05.
//

import SwiftUI

struct EventListRowView<Value: ItemViewModelable>: View {
    @ObservedObject var listRowViewModel: Value
    @State var isPresented: Bool = false
    @State var isPopOvered: Bool = false

    var body: some View {
        VStack {
            Text(listRowViewModel.output.currentEvent.title)
                .font(.title)
            Text(listRowViewModel.output.currentEvent.description)
                .font(.body)
                .foregroundColor(.gray)
        }.onTapGesture {
            self.isPresented = true
        }
        .sheet(isPresented: $isPresented) {
            self.isPresented = false
        } content: {
            DetailEventView(detailViewModel: listRowViewModel.output.detailViewModel,
                            id: UUID())
        }
        .onLongPressGesture {
            isPopOvered.toggle()
        }
        .popover(isPresented: $isPopOvered) {
            PopOverView(eventState: listRowViewModel.output.currentEvent.state,
                        viewModel: listRowViewModel)
        }
    }
}
