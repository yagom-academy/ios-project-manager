//
//  HistoryView.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/04.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject private var historyViewModel: HistoryViewModel
    let superSize: CGSize
    
    init(superSize: CGSize) {
        self.superSize = superSize
    }
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                ForEach(historyViewModel.historyList) { history in
                    card(history)
                }
            }
        }
        .frame(width: superSize.width * 0.4, height: superSize.height * 0.4, alignment: .leading)
        .padding()
        .background(.ultraThickMaterial)
    }
    
    private func card(_ history: History) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(history.title)
                .font(.title3)
            
            Text(history.date.formatted(date: .numeric, time: .standard))
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(10)
        .background(Color(.systemBackground))
        .cornerRadius(10)
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(superSize: CGSize(width: 300, height: 300))
    }
}
