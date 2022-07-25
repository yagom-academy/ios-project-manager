//
//  DetailViewModel.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/07.
//

struct DetailViewModel {
    private let content: ProjectContent
    
    init(content: ProjectContent) {
        self.content = content
    }
    
    func read() -> ProjectContent? {
        return ProjectUseCase().read(id: content.id)
    }
    
    func update(_ content: ProjectContent) {
        ProjectUseCase().update(projectContent: content)
    }
    
    func asContent() -> ProjectContent {
        return content
    }
}
