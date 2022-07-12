//
//  CellView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/12.
//

import SwiftUI

struct CellView: View {
    var contentViewModel: ContentViewModel
    @State private var showSheet = false
    @State private var isShowingPopover = false
    
    var body: some View {
        Button {
            showSheet.toggle()
        } label: {
            ListRowView(contentViewModel: contentViewModel)
        }
        .onLongPressGesture(minimumDuration: 1) {
            isShowingPopover.toggle()
        }
        .popover(isPresented: $isShowingPopover,
                 arrowEdge: .bottom) {
            PopoverButton(contentViewModel: contentViewModel)
        }
                 .sheet(isPresented: $showSheet) {
                     RegisterView(contentViewModel: contentViewModel)
                 }
    }
}

struct PopoverButton: View {
    var contentViewModel: ContentViewModel
    
    var body: some View {
        Form {
            Button(action: {
                contentViewModel.moveData(contentViewModel.data.task!, from: .todo, to: .doing)
            }) {
                Text("Move to DOING")
            }
            Button(action: {
                contentViewModel.moveData(contentViewModel.data.task!, from: .todo, to: .done)
            }) {
                Text("Move to DONE")
            }
        }.frame(width: 190, height: 90, alignment: .center)
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        CellView(contentViewModel: ContentViewModel())
    }
}
