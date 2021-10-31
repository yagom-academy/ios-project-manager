//
//  EventView.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/10/31.
//

import SwiftUI

struct EventView: View {
    var title: String
    var description: String
    var date: String
    var body: some View {
        VStack {
            Text(title)
            Text(description)
            Text(date)
        }
    }
}

