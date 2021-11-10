//
//  EventListHeaderView.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/11/07.
//

import SwiftUI

struct EventListHeader: View {
    let eventTitle: String
    var eventNumber: String
    
    var body: some View {
        HStack {
            Text(eventTitle)
                .font(.largeTitle)
            Text(eventNumber)
                .font(.title3)
                .foregroundColor(.white)
                .padding()
                .background(Circle())
            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemGray6))
    }
}
