//
//  ProjectManagerMainViewModel.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/10.
//

import Foundation

final class ProjectManagerMainViewModel: ObservableObject {
    
    @Published var isShowSheet = false
    
    func toggleSheetCondition() {
        isShowSheet.toggle()
    }
    
}
