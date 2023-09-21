//
//  TaskAddView.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 2023/09/20.
//

import SwiftUI

struct TaskAddView: View {
    @State private var title = ""
    @State private var date = Date()
    @State private var content = ""
    @Binding var isOn: Bool
    
    init(isOn: Binding<Bool>) {
        self._isOn = isOn
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.tertiarySystemGroupedBackground
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
    }
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
            NavigationView {
                VStack {
                    TextField("", text: $title)
                        .textFieldStyle(.roundedBorder)
                        .font(.title)
                        .shadow(color: .secondary, radius: 1, x: 5, y: 3)
                    DatePicker("", selection: $date)
                        .datePickerStyle(.wheel)
                    TextEditor(text: $content)
                        .font(.body)
                        .shadow(color: .secondary, radius: 1, x: 5, y: 3)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            isOn = false
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") {
                            isOn = false
                        }
                    }
                }
                .padding()
                .navigationTitle("Todo")
                .navigationBarTitleDisplayMode(.inline)
            }            
            .frame(width: 400, height: 500)
            .navigationViewStyle(.stack)
            .cornerRadius(10)            
        }        
    }
}

struct TaskAddView_Previews: PreviewProvider {
    static var previews: some View {
        TaskAddView(isOn: .constant(true))
    }
}
