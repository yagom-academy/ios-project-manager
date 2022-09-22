import SwiftUI

struct ProjectAddView: View {
    @ObservedObject var viewModel: ProjectModalViewModel
    @Binding var project: [Project]

    init(viewModel: ProjectModalViewModel, project: Binding<[Project]>) {
        self.viewModel = viewModel
        self._project = project
    }

    var body: some View {
        VStack {
            ProjectAddTitleView(viewModel: viewModel, projects: $project)
            ProjectAddTitleTextView(viewModel: viewModel)
            ProjectAddDatePickerView(viewModel: viewModel)
            ProjectAddDetailTextView(viewModel: viewModel)
        }
    }

    struct ProjectAddTitleView: View {
        @Environment(\.dismiss) var dismiss
        @ObservedObject var viewModel: ProjectModalViewModel
        @Binding var projects: [Project]

        var body: some View {
            HStack {
                Button(action: {
                    dismiss()
                }, label: {
                    Text(NameSpace.cancelButton)
                        .font(.title3)
                })
                .padding(10)
                Spacer()
                Text(NameSpace.projectTitle)
                    .font(.title)
                Spacer()
                Button(action: {
                    projects.append(Project(id: viewModel.id,
                                            status: .todo,
                                            title: viewModel.title,
                                            detail: viewModel.detail,
                                            date: viewModel.date))
                    dismiss()
                }, label: {
                    Text(NameSpace.doneButton)
                        .font(.title3)
                        .padding(10)
                })
            }
        }
    }

    struct ProjectAddTitleTextView: View {
        @ObservedObject var viewModel: ProjectModalViewModel

        var body: some View {
            ZStack {
                Rectangle()
                    .fill(Color(.systemBackground))
                    .frame(width: 680, height: 60, alignment: .center)
                    .shadow(color: .gray, radius: 8, x: 0, y: 0)
                TextField(NameSpace.titleSpaceHolder, text: $viewModel.title)
                    .padding()
                    .background(Color(.systemBackground))
                    .padding(12)
                    .disableAutocorrection(true)
            }
        }
    }

    struct ProjectAddDatePickerView: View {
        @ObservedObject var viewModel: ProjectModalViewModel

        var body: some View {
            DatePicker("",
                       selection: $viewModel.date,
                       displayedComponents: .date)
            .datePickerStyle(WheelDatePickerStyle())
            .labelsHidden()
        }
    }

    struct ProjectAddDetailTextView: View {
        @ObservedObject var viewModel: ProjectModalViewModel

        var body: some View {
            ZStack {
                Rectangle()
                    .fill(Color(.systemBackground))
                    .frame(width: 680, height: 530, alignment: .center)
                    .shadow(color: .gray, radius: 8, x: 0, y: 0)
                if viewModel.detail.isEmpty {
                    TextEditor(text: $viewModel.placeholder)
                        .font(.body)
                        .padding()
                }
                TextEditor(text: $viewModel.detail)
                    .font(.body)
                    .frame(width: 680, height: 530, alignment: .center)
                    .background(Color(.systemBackground))
                    .opacity(viewModel.detail.isEmpty ? 0.15 : 1)
                    .padding(12)
                    .disableAutocorrection(true)
            }
        }
    }
}

extension ProjectAddView {
    enum NameSpace {
        static let projectTitle = "Project Manager"
        static let cancelButton = "Cancel"
        static let doneButton = "Done"
        static let titleSpaceHolder = "Title"
    }
}
