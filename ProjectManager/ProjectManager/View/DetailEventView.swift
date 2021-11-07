//
//  DetailEventView.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/10/31.
//
//

import SwiftUI
// delegate여기서 채택
struct DetailEventView<T: DetailViewModelable>: View {
    @State private var eventTitle: String = ""
    @State private var navigationTitle: String = "ToDo"
    @State private var description: String = ""
    
    var detailViewModel: T // rc
    var id: UUID
        
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(alignment: .center) {
                    Form {
                        TextField("title",
                                  text: $eventTitle,
                                  onCommit: {
                            detailViewModel.input.onSaveTitle(title: eventTitle)
                        })
                            .background(Color.white)
                            .font(.title)
                            .frame(height: geometry.size.height * 0.05,
                                   alignment: .center)
                            .compositingGroup()
                            .shadow(color: Color.red,
                                    radius: 10,
                                    x: 0, y: 0)
                        //                        HStack {
                        //                            Spacer()
                        //                            DatePicker(selection: $detailViewModel.output.event.date, label: {})
                        //                                .datePickerStyle(.wheel)
                        //                                .labelsHidden()
                        //                            Spacer()
                        //                        }
                        TextEditor(text: $description)
                            .onChange(of: description) {
                                detailViewModel
                                    .input
                                    .onSaveDescription(description:
                                                        String($0.prefix(1000)))
                                
                            }
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
                    // EditButtonView()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    //  DoneEventButton()
                }
            }
        }
        .onAppear(perform: {
            self.eventTitle = detailViewModel.output.event.title
            self.description = detailViewModel.output.event.description
        })
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarTitleDisplayMode(.inline)
    }
}
//
//struct DoneEventButton: View {
//    @EnvironmentObject var viewModel: ProjectManager
//    @Environment(\.presentationMode) var presentationMode
//    
//    var body: some View {
//        if #available(iOS 15.0, *) {
//            Button("Done", role: .none) {
//                self.viewModel.update()
//                self.presentationMode.wrappedValue.dismiss()
//            }
//        } else {
//            
//        }
//    }
//}
//
//struct EditButtonView: View {
//    @Environment(\.presentationMode) var presentationMode
//    @EnvironmentObject var viewModel: ProjectManager
//    
//    @State var showEditButton: Bool = false
//    @State var title: String = "Cancel"
//    var body: some View {
//        
//        Button {
//            self.showEditButton.toggle()
//            self.title = "Edit"
//            self.viewModel.update()
//        } label: {
//            Text(title)
//        }
//    }
//}
//struct AddEventButton: View {
//    @State private var isButtonTabbed: Bool = false
//    @EnvironmentObject var viewModel: ProjectManager
//
//    var body: some View {
//        Button("+") {
//            isButtonTabbed.toggle()
//            self.viewModel.create()
//        }.sheet(isPresented: $isButtonTabbed,
//                onDismiss: {
//
//        }, content: {
//            DetailEventView(id: UUID())
//                .environmentObject(viewModel)
//        })
//    }
//}
