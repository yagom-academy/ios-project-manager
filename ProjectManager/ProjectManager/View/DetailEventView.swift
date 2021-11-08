//
//  DetailEventView.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/10/31.
//
//

import SwiftUI

struct DetailEventView<T: DetailViewModelable>: View {
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var eventTitle: String = ""
    @State private var navigationTitle: String = "ToDo"
    @State private var description: String = ""
    @State private var date: Date = Date()
    
    @State private var isInteractionDisabled: Bool = true
    
    var detailViewModel: T
    var id: UUID
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(alignment: .center) {
                    Form {
                        TextField("title",
                                  text: $eventTitle)
                            .font(.title)
                            .padding()
                            .background(Color.white.shadow(color: .gray, radius: 3, x: 1, y: 4))
                        HStack {
                            Spacer()
                            DatePicker(selection: $date, label: {})
                                .datePickerStyle(.wheel)
                                .labelsHidden()
                            Spacer()
                        }
                        TextEditor(text: $description)
                            .frame(height: geometry.size.height * 0.5,
                                   alignment: .center)
                            .font(.title)
                            .padding()
                            .background(Color.white.shadow(color: .gray, radius: 3, x: 1, y: 4))
                    }.disabled(isInteractionDisabled)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    editButton
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    cancelButton
                }
            }
        }
        .onAppear(perform: {
            self.eventTitle = detailViewModel.output.event.title
            self.description = detailViewModel.output.event.description
            self.date = detailViewModel.output.event.date
        })
        .navigationViewStyle(.stack)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var cancelButton: some View {
        Button(ButtonTitle.cancel.rawValue) {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
    var editButtonTitle: String {
        get {
            if self.isInteractionDisabled {
                return ButtonTitle.edit.rawValue
            } else {
                return ButtonTitle.done.rawValue
            }
        }
    }
    
    var editButton: some View {
        Button(editButtonTitle) {
            self.isInteractionDisabled.toggle()
        }
        .onChange(of: isInteractionDisabled) { newValue in
            if newValue {
                saveEvent()
            }
        }
    }
    
    private func saveEvent() {
        detailViewModel
            .input
            .onSaveDescription(description: String(self.description.prefix(1000)))
        detailViewModel
            .input
            .onSaveTitle(title: self.eventTitle)
        detailViewModel.input.onSaveDate(date: self.date)
    }
    
    enum ButtonTitle: String {
        case cancel = "Cancel"
        case done = "Done"
        case edit = "Edit"
    }
}

