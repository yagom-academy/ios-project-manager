//
//  ContentView.swift
//  ProjectManager
//
//  Created by 재재, 언체인 on 2022/09/08.
//

import SwiftUI

struct TodoListMainView: View {
    @StateObject var viewModel = ProjectMainViewModel()

    var body: some View {
        VStack {
            ProjectTitleView(model: $viewModel.model)
            HStack {
                VStackView(viewModel: viewModel, projects: $viewModel.model, title: Status.todo.rawValue, count: viewModel.todoArray.count, status: .todo)
                VStackView(viewModel: viewModel, projects: $viewModel.model, title: Status.doing.rawValue, count: viewModel.doingArray.count, status: .doing)
                VStackView(viewModel: viewModel, projects: $viewModel.model, title: Status.done.rawValue, count: viewModel.doneArray.count, status: .done)
            }
            .background(Color(UIColor.systemGray3))
        }
    }

    struct ProjectTitleView: View {
        @Binding var model: [Project]
        @State private var showModal = false

        var body: some View {
            ZStack {
                HStack {
                    Spacer()
                    Text("Project Manager")
                        .font(.title)
                    Spacer()
                }
                HStack {
                    Spacer()
                    Button(action: {
                        self.showModal = true
                    }, label: {
                        Image(systemName: "plus")
                    })
                    .sheet(isPresented: self.$showModal, content: {
                        TodoListAddView(viewModel: ProjectModalViewModel(project: Project()), project: $model)
                    })
                    .font(.title)
                    .padding(10)
                }
            }
        }
    }

    struct VStackView: View {
        @ObservedObject var viewModel: ProjectMainViewModel
        @State var selectedProject: Project?
        @Binding var projects: [Project]

        let title: String
        let count: Int
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
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy.MM.dd"
            return formatter
        }()

        var body: some View {
            VStack(alignment: .leading) {
                HStack {
                    Spacer().frame(width: 10)
                    Text(title)
                        .font(.largeTitle)
                    ZStack {
                        Circle()
                            .fill(.black)
                            .frame(width: 30, height: 30)
                        Text("\(count)")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                }
                List(array) { memo in
                    VStack(alignment: .leading) {
                        Text(memo.title!)
                        Text(memo.detail!)
                        Text(memo.date!, formatter: dateFormatter)
                    }
                    .sheet(item: $selectedProject) { memo in
                        TodoListEditView(viewModel: ProjectModalViewModel(project: memo), projects: $projects)
                    }
                    .onTapGesture {
                        selectedProject = memo
                    }
                }
            }
            .background(Color(UIColor.systemGray5))
            Divider()
        }
    }
}
