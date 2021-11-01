//
//  DetailEventView.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/10/31.
//

import SwiftUI

struct DetailEventView: View {
    @State private var eventTitle: String = ""
    @State private var navigationTitle: String = "ToDo"
    @State private var description: String = ""
    @State private var selectedDate: Date = Date()
    
    @EnvironmentObject var viewModel: ProjectLists
    @State var dismissSheet: Bool = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(alignment:.center) {
                    Form {
                        TextField(eventTitle, text: $eventTitle)
                            .background(Color.white)
                            .compositingGroup()
                            .shadow(color: Color.red, radius: 10, x: 0, y: 0)
                            .frame(height: geometry.size.height * 0.05, alignment: .center)
                            .font(.title)
                        
                        HStack {
                            Spacer()
                            DatePicker("",
                                       selection: $selectedDate,
                                       displayedComponents: [.date])
                                .datePickerStyle(WheelDatePickerStyle())
                                .fixedSize()
                            Spacer()
                        }
                        
                        TextField(description, text: $description, onCommit: {
                            self.viewModel.input.descriptionText = description
                        })
                            .frame(height: geometry.size.height * 0.5, alignment: .center)
                            .background(Color.white)
                            .compositingGroup()
                            .shadow(color: Color.red, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                    }
                }
            }
            .toolbar(content: {
                DoneEventButton()
                    .environmentObject(viewModel)
                
            })
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarTitle(Text(navigationTitle))
        .navigationBarTitleDisplayMode(.inline)
    }
}

