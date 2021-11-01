//
//  DetailEventView.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/10/31.
//

import SwiftUI

struct DetailEventView: View {
    @State private var eventTitle: String = "eventTitle"
    @State private var navigationTitle: String = "asdf"
    @State private var description: String = "description"
    @State private var selectedDate: Date = Date()
    
    init(eventTitle: String, navigationTitle: String, description: String) {
        self.eventTitle = eventTitle
        self.navigationTitle = navigationTitle
        self.description = description
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(alignment:.center) {
                    Form {
                        TextField(eventTitle, text: $eventTitle)
                            .frame(height: geometry.size.height * 0.05, alignment: .center)
                            .font(.title)
                            .background(Color.white)
                            .compositingGroup()
                            .shadow(color: Color.red, radius: 5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                        HStack {
                            Spacer()
                            DatePicker("",
                                       selection: $selectedDate,
                                       displayedComponents: [.date])
                                .datePickerStyle(WheelDatePickerStyle())
                                .fixedSize(horizontal: true, vertical: false)
                            Spacer()
                        }
                        
                        TextField(description, text: $description)
                            .frame(height: geometry.size.height * 0.5, alignment: .center)
                            .background(Color.white)
                            .compositingGroup()
                            .shadow(color: Color.red, radius: 5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                    }
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
        .navigationBarTitle(Text(navigationTitle))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
        })
        
    }
}
