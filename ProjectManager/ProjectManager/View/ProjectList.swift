//
//  ProjectList.swift
//  ProjectManager
//
//  Created by 홍정아 on 2021/11/02.
//

import SwiftUI

struct ProjectList: View {
    var projects: [ProjectModel.Project]
    
    var body: some View {
        List {
            Section(header: header) {
                ForEach(projects) { project in
                    ProjectRow(project: project)
                }
            }
        }
        .listStyle(GroupedListStyle())
        .background(Color(.systemGray5))
    }
    
    var header: some View {
        HStack {
            Text(projects[0].status.header)
                        .foregroundColor(.primary)
                        .font(.title)
            Image(systemName: "\(projects.count).circle.fill")
                .font(.title2)
                .foregroundColor(.black)
        }
    }
}

struct ProjectList_Previews: PreviewProvider {
    static var previews: some View {
        ProjectList(projects: [
            ProjectModel.Project(id: UUID(),
                                 title: "책상정리",
                                 content: "집중이 안될땐 역시나 책상정리",
                                 dueDate: Date(),
                                 created: Date(timeIntervalSince1970: 1649651333),
                                 status: .todo),
            ProjectModel.Project(id: UUID(),
                                 title: "라자냐 재료사러 가기",
                                 content: "프로젝트 회고를 작성하면 내가 이번 프로젝트에서 무엇을 놓쳤는지 명확히 알 수 있어요.",
                                 dueDate: Date(timeIntervalSince1970: 1564223600),
                                 created: Date(timeIntervalSince1970: 1538651333),
                                 status: .todo),
            ProjectModel.Project(id: UUID(),
                                 title: "일기쓰기",
                                 content: "난...ㄱㅏ끔...일ㄱㅣ를 쓴ㄷㅏ...",
                                 dueDate: Date(timeIntervalSince1970: 1608651333),
                                 created: Date(timeIntervalSince1970: 1588651333),
                                 status: .todo),
            ProjectModel.Project(id: UUID(),
                                 title: "설거지하기",
                                 content: "밥을 먹었으면 응당 해야할 일",
                                 dueDate: Date(timeIntervalSince1970: 1624223600),
                                 created: Date(timeIntervalSince1970: 1574223600),
                                 status: .todo),
            ProjectModel.Project(id: UUID(),
                                 title: "빨래하기",
                                 content: "그만 쌓아두고...\n근데...\n여전히 하기 싫다",
                                 dueDate: Date(timeIntervalSince1970: 1694223600),
                                 created: Date(timeIntervalSince1970: 1554223600),
                                 status: .todo)
        ])
    }
}
