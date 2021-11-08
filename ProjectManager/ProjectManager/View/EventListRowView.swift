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
    
    private func decideDateTextColor() -> Color {
        if self.listRowViewModel.output.isOutDated {
            return Color.red
        }
        return .black
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(listRowViewModel.output.currentEvent.title)
                .font(.title)
            Text(listRowViewModel.output.currentEvent.description)
                .frame(height: 30, alignment: .leading)
                .font(.body)
                .foregroundColor(.gray)
            Text(listRowViewModel.output.currentEvent.date, style: .date)
                .font(.callout)
                .foregroundColor(decideDateTextColor())
        }
        .onTapGesture {
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
