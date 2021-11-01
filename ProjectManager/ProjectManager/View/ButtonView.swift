//
//  ButtonView.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/11/01.
//

import SwiftUI

struct AddEventButton: View {
    @State private var isButtonTabbed: Bool = false
    
    var body: some View {
        Button("+") {
            isButtonTabbed.toggle()
            print("NewEvent")
        }.sheet(isPresented: $isButtonTabbed, onDismiss: {
            
        }, content: {
            DetailEventView()
        })
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddEventButton()
    }
}
