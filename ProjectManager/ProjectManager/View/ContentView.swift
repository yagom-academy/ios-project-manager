//
//  ContentView.swift
//  ProjectManager
//
//  Created by 예거 on 2022/02/28.
//

import SwiftUI
import Firebase

struct ContentView: View {
    var body: some View {
        Text("프로젝트 관리 앱")
            .font(.largeTitle)
            .onAppear {
                print("💚 화면 두두등장!")
                // Firestore
                // let database = Firestore.firestore()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            ContentView()
                .previewInterfaceOrientation(.landscapeRight)
        } else {
            ContentView()
        }
    }
}
