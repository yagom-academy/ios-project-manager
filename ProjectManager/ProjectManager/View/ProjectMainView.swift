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
                        .font(.largeTitle)
                    Spacer()
                }
                HStack {
                    Spacer()
                    Button(action: {
                        self.showModal = true
                    }, label: {
                        Image(systemName: NameSpace.plusButton)
                    })
                    .sheet(isPresented: self.$showModal, content: {
                        ProjectAddView(viewModel: ProjectModalViewModel(project: Project()), project: $viewModel.model)
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
        var array: [Project] {
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
                    Spacer().frame(width: 10)
                    Text(title)
                        .font(.largeTitle.bold())
                    ZStack {
                        Circle()
                            .fill(.black)
                            .frame(width: 30, height: 30)
                        Text("\(array.count)")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                    .frame(height: 60, alignment: .center)
                }
                Divider()
                Spacer()
                List {
                    ForEach(array, id: \.self) { project in
                        ProjectContentView(viewModel: viewModel, project: project)
                    }
                    .onDelete { index in
                        viewModel.delete(at: index, status: status)
                    }
                }
            }
            .background(Color(UIColor.systemGray5))
            Divider()
        }
    }
}

extension ProjectMainView {
    enum NameSpace {
        static let projectTitle = "Project Manager"
        static let plusButton = "plus"
    }
}
