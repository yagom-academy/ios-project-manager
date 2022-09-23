//
//  ProjectMainView.swift
//  ProjectManager
//
//  Created by 재재, 언체인 on 2022/09/08.
//

import SwiftUI

struct ProjectMainView: View {
    @StateObject var viewModel = ProjectMainViewModel()

    var body: some View {
        VStack(alignment: .center) {
            ProjectMainTitleView(viewModel: viewModel)
            HStack {
                ProjectStatusListView(viewModel: viewModel, title: Status.todo.rawValue, status: .todo)
                ProjectStatusListView(viewModel: viewModel, title: Status.doing.rawValue, status: .doing)
                ProjectStatusListView(viewModel: viewModel, title: Status.done.rawValue, status: .done)
            }
            .background(Color(UIColor.systemGray3))
        }
    }

    struct ProjectMainTitleView: View {
        @ObservedObject var viewModel: ProjectMainViewModel
        @State private var showModal = false

        var body: some View {
            ZStack {
                HStack {
                    Spacer()
                    Text(NameSpace.projectTitle)
                        .font(.largeTitle.monospacedDigit().bold())
                        .foregroundColor(Color("ZEZEColor"))
                    Spacer()
                }
                HStack {
                    Spacer()
                    Button(
                        action: {
                            self.showModal = true
                        },
                        label: {
                            Image(systemName: NameSpace.plusButton)
                        })
                    .foregroundColor(Color("ZEZEColor"))
                    .sheet(isPresented: self.$showModal, content: {
                        ProjectAddView(viewModel: ProjectModalViewModel(project: Project()),
                                       project: $viewModel.model,
                                       showModal: $showModal)
                    })
                    .font(.title)
                    .padding(10)
                }
            }
        }
    }

    struct ProjectStatusListView: View {
        @ObservedObject var viewModel: ProjectMainViewModel

        var title: String
        var status: Status
        var distinguishProjects: [Project] {
            switch status {
            case .todo:
                return viewModel.todoArray
            case .doing:
                return viewModel.doingArray
            case .done:
                return viewModel.doneArray
            }
        }

        var body: some View {
            VStack(alignment: .center, spacing: 0) {
                HStack {
                    Text(title)
                        .font(.largeTitle.bold())
                        .foregroundColor(Color.white)
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 33, height: 33)
                        Text("\(distinguishProjects.count)")
                            .font(.title2.bold())
                            .foregroundColor(Color("ZEZEColor"))
                    }
                }
                .padding()
                List {
                    ForEach(distinguishProjects, id: \.self) { project in
                        ProjectContentView(viewModel: viewModel, project: project)
                            .border(Color("BorderColor"), width: 3)
                            .cornerRadius(5)
                    }
                    .onDelete { index in
                        viewModel.delete(at: index, status: status)
                    }
                }
                .listStyle(.sidebar)
            }
            .background(Color("ZEZEColor"))
        }
    }
}

extension ProjectMainView {
    enum NameSpace {
        static let projectTitle = "PROJECT MANAGER"
        static let plusButton = "plus"
    }
}
