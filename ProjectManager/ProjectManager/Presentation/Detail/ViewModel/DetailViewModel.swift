//
//  DetailViewModel.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/07.
//

struct DetailViewModel {
    let content: ProjectContent
    
    init(content: ProjectContent) {
        self.content = content
    }
    
    func update(_ content: ProjectContent) {
        ProjectUseCase().repository.update(projectContent: content)
    }
}
