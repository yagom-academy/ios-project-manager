//
//  MainView.swift
//  ProjectManager
//
//  Created by Yetti on 2023/09/20.
//

import SwiftUI
import FirebaseAnalyticsSwift



struct MainView: View {
    var body: some View {
        Text("Hello, 호에에에!")
            .analyticsScreen(name: "\(MainView.self)")
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
