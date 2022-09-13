//
//  ProjectAddViewModel.swift
//  ProjectManager
//
//  Created by 재재, 언체인 on 2022/09/13.
//

import SwiftUI

final class ProjectAddViewModel: ObservableObject {
    @Published var title = Project().title ?? ""
    @Published var detail = Project().detail ?? ""
    @Published var date = Project().date ?? Date()
    @Published var id = Project().id ?? UUID()
    @Published var status = Project().status ?? .none
    @Published var placeholder = Project().placeholder
}
