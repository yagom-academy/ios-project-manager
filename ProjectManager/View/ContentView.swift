//
//  ContentView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/05.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        NavigationView {
            HStack {
                VStack(alignment: .leading) {
                        List {
                            Section(header: TodoView()) {
                            ListRowView()
                        }
                    }
                }
                VStack(alignment: .leading) {
                        List {
                            Section(header: DoingView()) {
                            ListRowView()
                        }
                    }
                }
                VStack(alignment: .leading) {
                        List {
                            Section(header: DoneView()) {
                            ListRowView()
                        }
                    }
                }
            }
            .navigationTitle("Project Manager")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarColor(.systemGray5)
        }
        .navigationViewStyle(.stack)
    }
}
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                .previewInterfaceOrientation(.landscapeLeft)
        }
    }
