//
//  ProjectDetail.swift
//  ProjectManager
//
//  Created by 홍정아 on 2021/11/05.
//

import SwiftUI

struct ProjectDetail: View {
    @ObservedObject var viewModel: DetailViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            textEditor
                .disabled(viewModel.disabled)
                .navigationBarItems(leading: leftButton, trailing: doneButton)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    var doneButton: some View {
        Button {
            viewModel.update()
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Done")
        }
    }
    
    var leftButton: some View {
        viewModel.disabled ? AnyView(editButton) : AnyView(cancelButton)
    }
    
    var cancelButton: some View {
        Button() {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Cancel")
        }
    }
    
    var editButton: some View {
        Button {
            viewModel.disabled = false
        } label: {
            Text("Edit")
        }
    }
    
    var textEditor: some View {
        VStack(alignment: .center) {
            TextField("Title", text: $viewModel.title)
                .padding(.horizontal)
                .frame(height: 50)
                .background(Color.white.cornerRadius(5))
                .shadow(color: .gray, radius: 5, x: -1, y: 5)
            DatePicker("", selection: $viewModel.selectedDate, displayedComponents: [.date])
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
            TextEditor(text: $viewModel.content)
                .frame(maxHeight: .infinity)
                .multilineTextAlignment(.leading)
                .lineSpacing(5)
                .background(Color.white.cornerRadius(5))
                .shadow(color: .gray, radius: 5, x: -1, y: 5)
        }
        .padding()
        .navigationTitle(viewModel.header)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        UINavigationBar.appearance().backgroundColor = UIColor(Color(.systemGray6))
    }
}

//struct ProjectDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        ProjectDetail()
//            .previewLayout(.fixed(width: 1136 * 2/3, height: 820))
//    }
//}
