//
//  MainView.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/10/31.
//

import SwiftUI

struct MainView<T: MainViewModelable>: View {
    @ObservedObject var viewModel: T
    @State var isButtonTabbed: Bool = false

    var body: some View {
        NavigationView {
                HStack {
                    EventListView(eventListviewModels: viewModel.output.eventListViewModel)
                }
                .navigationBarTitle("프로젝트 관리")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: button)
            }
            .navigationViewStyle(.stack)
        }
    
    var button: some View {
        Button("+") {
            isButtonTabbed.toggle()
        }
        .sheet(isPresented: $isButtonTabbed) {
            self.isButtonTabbed = false
        } content: {
            DetailEventView(detailViewModel:
                                self.viewModel.output
                                .currentEvetDetailViewModel!, id: UUID())
        }.onChange(of: isButtonTabbed) { newValue in
            if newValue {
                self.viewModel.input.onTouchEventCreateButton()
            }
        }
        .font(.title2)
    }
}
