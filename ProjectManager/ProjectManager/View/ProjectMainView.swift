//
//  ProjectView.swift
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
        @State var isPopover = false

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
                    ForEach(array, id: \.self) { memo in
                        ProjectContentView(viewModel: viewModel, memo: memo)
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

struct ProjectContentView: View {
    @ObservedObject var viewModel: ProjectMainViewModel
    @State var selectedProject: Project?
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
            viewModel.project = memo
            isPopover = true
        })
        .sheet(item: $selectedProject) { memo in
            ProjectEditView(viewModel: ProjectModalViewModel(project: memo), projects: $viewModel.model)
        }
        .popover(isPresented: $isPopover) {
            VStack {
                ForEach(Status.allCases
                    .filter { $0 != viewModel.project?.status }, id: \.self) { status in
                        Button("move to \(status.rawValue)", action: {
                            isPopover = false
                            viewModel.model = viewModel.model.map({ project in
                                guard project.id == viewModel.project?.id else { return project }
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
