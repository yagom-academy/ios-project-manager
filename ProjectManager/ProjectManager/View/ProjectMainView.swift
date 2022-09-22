import SwiftUI

struct ProjectMainView: View {
    @StateObject var viewModel = ProjectMainViewModel()

    var body: some View {
        VStack(alignment: .center) {
            ProjectMainTitleView(viewModel: viewModel)
            HStack {
                ProjectStatusListView(viewModel: viewModel, title: Status.todo.rawValue, status: .todo)
                Divider()
                ProjectStatusListView(viewModel: viewModel, title: Status.doing.rawValue, status: .doing)
                Divider()
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
                    Button(action: {
                        self.showModal = true
                    }, label: {
                        Image(systemName: NameSpace.plusButton)
                    })
                    .foregroundColor(Color("ZEZEColor"))
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
                        .foregroundColor(Color.white)
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 33, height: 33)
                        Text("\(array.count)")
                            .font(.title2.bold())
                            .foregroundColor(Color("ZEZEColor"))
                    }
                    .frame(height: 60, alignment: .center)
                }
                Divider()
                Spacer()
                List {
                    ForEach(array, id: \.self) { project in
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
