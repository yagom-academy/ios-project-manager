//
//  ListRowView.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/11/05.
//

import SwiftUI

struct ListRowView<T: ListRowViewModelable, Value: DetailViewModelable>: View {
    @ObservedObject var listRowViewModel: T
    @ObservedObject var detailViewModel: Value
    
    @State var isPresented: Bool = false
    var body: some View {
        print(#function)
        return VStack {
            Text(detailViewModel.output.event.title)
                .font(.title)
            
            Text(detailViewModel.output.event.description)
                .font(.body)
                .foregroundColor(.gray)
        }.onTapGesture {
            self.isPresented = true
        }
        .sheet(isPresented: $isPresented) {
            self.isPresented = false
        } content: {
            DetailEventView(detailViewModel: listRowViewModel.output.detailViewModel, id: UUID())
        }
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//       ListRowView(listRowViewModel: ListRowViewModel(isOnTest: true))
//    }
//}
