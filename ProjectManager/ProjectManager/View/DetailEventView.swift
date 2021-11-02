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
    //@State private var selectedDate: Date = Date()
    
    @EnvironmentObject var viewModel: EventsList
    
    var id: UUID
    private let emptyString = ""
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(alignment:.center) {
                    Form {
                        TextField(viewModel.manager.read(id)?.title ?? emptyString,
                                  text: $eventTitle,
                                  onCommit: {
                            self.viewModel.input.titleText = eventTitle
                        })
                            .background(Color.white)
                            .font(.title)
                            .frame(height: geometry.size.height * 0.05,
                                   alignment: .center)
                            .compositingGroup()
                            .shadow(color: Color.red,
                                    radius: 10,
                                    x: 0, y: 0)
                        HStack {
                            Spacer()
                            DatePicker("",
                                       selection: $viewModel.input.dateText,
                                       displayedComponents: [.date])
                                .datePickerStyle(WheelDatePickerStyle())
                                .fixedSize()
                            Spacer()
                        }
                        
                        TextField(viewModel.manager.read(id)?.description ?? emptyString,
                                  text: $description,
                                  onCommit: {
                            self.viewModel.input.descriptionText = description
                        })
                            .frame(height: geometry.size.height * 0.5,
                                   alignment: .center)
                            .background(Color.white)
                            .compositingGroup()
                            .shadow(color: Color.red,
                                    radius: 10,
                                    x: 0, y: 0)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButtonView()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    DoneEventButton()
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarTitle(Text(navigationTitle))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DoneEventButton: View {
    @EnvironmentObject var viewModel: EventsList
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        if #available(iOS 15.0, *) {
            Button("Done", role: .none) {
                self.viewModel.update()
                self.presentationMode.wrappedValue.dismiss()
            }
        } else {
            
        }
    }
}

struct EditButtonView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: EventsList
    
    @State var showEditButton: Bool = false
    @State var title: String = "Cancel"
    var body: some View {
        
        Button {
            self.showEditButton.toggle()
            self.title = "Edit"
            self.viewModel.update()
        } label: {
            Text(title)
        }
    }
}

