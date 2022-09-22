//
//  TodoListMainView.swift
//  ProjectManager
//
//  Created by 재재, 언체인 on 2022/09/08.
//

import SwiftUI

struct TodoListMainView: View {
    @StateObject var viewModel = ProjectMainViewModel()

    var body: some View {
        VStack(alignment: .center) {
            ProjectTitleView(model: $viewModel.model)
            HStack {
                VStackView(viewModel: viewModel, selectedProject2: $viewModel.project, projects: $viewModel.model, title: Status.todo.rawValue, count: viewModel.todoArray.count, status: .todo)
                VStackView(viewModel: viewModel, selectedProject2: $viewModel.project, projects: $viewModel.model, title: Status.doing.rawValue, count: viewModel.doingArray.count, status: .doing)
                VStackView(viewModel: viewModel, selectedProject2: $viewModel.project, projects: $viewModel.model, title: Status.done.rawValue, count: viewModel.doneArray.count, status: .done)
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
                        .font(.largeTitle)
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
        @Binding var selectedProject2: Project?
        @Binding var projects: [Project]
        @State var isPopover = false

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
                        Text("\(count)")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                    .frame(height: 60, alignment: .center)
                }
                Divider()
                Spacer()
                List {
                    ForEach(array, id: \.self) { memo in
                        ProjectContentView(viewModel: viewModel, selectedProject2: $selectedProject2, projects: $projects, memo: memo)
                    }
                    .onDelete { index in
                        removeRows(at: index)
                    }
                }
            }
            .background(Color(UIColor.systemGray5))
            Divider()
        }

        func removeRows(at offsets: IndexSet) {
            let filteredArray = projects.filter { todo in
                todo.status == status
            }
            guard let remove = offsets.first else { return }
            projects.removeAll { todo in
                todo.id == filteredArray[remove].id
            }
        }
    }
}

struct ProjectContentView: View {
    @ObservedObject var viewModel: ProjectMainViewModel
    @State var selectedProject: Project?
    @Binding var selectedProject2: Project?
    @Binding var projects: [Project]
    @State var isPopover = false
    var memo: Project
    let today = Calendar.current.startOfDay(for: Date())

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }()

    var body: some View {
        VStack(alignment: .leading) {
            Text(memo.title ?? "")
            Text(memo.detail ?? "")
            Text(memo.date ?? Date(), formatter: dateFormatter)
                .foregroundColor(memo.date! >= today ? .black : .red)
        }
        .onTapGesture {
            selectedProject = memo
        }
        .onLongPressGesture(minimumDuration: 1, perform: {
            selectedProject2 = memo
            isPopover = true
        })
        .sheet(item: $selectedProject) { memo in
            TodoListEditView(viewModel: ProjectModalViewModel(project: memo), projects: $projects)
        }
        .popover(isPresented: $isPopover) {
            VStack {
                ForEach(Status.allCases
                    .filter { $0 != selectedProject2?.status }, id: \.self) { status in
                        Button("move to \(status.rawValue)", action: {
                            isPopover = false
                            projects = projects.map({ project in
                                guard project.id == selectedProject2?.id else { return project }
                                var changedProject = project
                                changedProject.status = status
                                return changedProject
                            })
                        })
                        Divider()
                    }
            }
        }
    }
}
