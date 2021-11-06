//
//  ListRowView.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/11/05.
//

import SwiftUI

protocol Delegatable {
    func test()
}

struct EventListRowView<Value: ListRowViewModelable>: View, Delegatable {
    func test() {
      //  print("ㅜㅠㅜㅠㅜㅠㅜ")
        listRowViewModel.output.detailViewModel.objectWillChange.send()
        print(listRowViewModel.output.detailViewModel.event.title, "👍")
    }
    
    @ObservedObject var listRowViewModel: Value
    //@ObservedObject var detailViewModel: Value
    
    @State var isPresented: Bool = false
    var body: some View {
        print(#function)
        return VStack {
            Text(listRowViewModel.output.detailViewModel.event.title)
                .font(.title)
            Text(listRowViewModel.output.detailViewModel.event.description)
                .font(.body)
                .foregroundColor(.gray)
        }.onTapGesture {
            self.isPresented = true
        }
        .sheet(isPresented: $isPresented) {
            self.isPresented = false
        } content: {
            DetailEventView(delegate: self,
                            detailViewModel: listRowViewModel.output.detailViewModel,
                            id: UUID())
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        EventListRowView(listRowViewModel: ListRowViewModel(isOnTest: true))
    }
}
