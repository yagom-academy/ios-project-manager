import SwiftUI

struct ProjectEditView: View {
    @ObservedObject var viewModel: ProjectModalViewModel
    @Binding var projects: [Project]

    var body: some View {
        VStack {
            ProjectEditTitleView(viewModel: viewModel, projects: $projects)
            ProjectEditTitleTextView(viewModel: viewModel)
            ProjectEditDatePickerView(viewModel: viewModel)
            ProjectEditDetailTextView(viewModel: viewModel)
        }
    }

    struct ProjectEditTitleView: View {
        @Environment(\.dismiss) var dismiss
        @ObservedObject var viewModel: ProjectModalViewModel
        @Binding var projects: [Project]

        var body: some View {
            HStack {
                Button(action: {
                    viewModel.isTappedEditButton()
                }, label: {
                    Text(NameSpace.editButton)
                        .font(.title3)
                })
                .padding(10)
                Spacer()
                Text(NameSpace.projectTitle)
                    .font(.title)
                Spacer()
                Button(action: {
                    projects = projects.map { project in
                        guard project.id == viewModel.id else { return project }
                        let changedProject = Project(id: viewModel.id,
                                                     status: viewModel.status,
                                                     title: viewModel.title,
                                                     detail: viewModel.detail,
                                                     date: viewModel.date)
                        return changedProject
                    }
                    dismiss()
                }, label: {
                    Text(NameSpace.doneButton)
                        .font(.title3)
                        .padding(10)
                })
            }
        }
    }

    struct ProjectEditTitleTextView: View {
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
            .disabled(viewModel.isDisable)
        }
    }

    struct ProjectEditDatePickerView: View {
        @ObservedObject var viewModel: ProjectModalViewModel

        var body: some View {
            DatePicker("",
                       selection: $viewModel.date,
                       displayedComponents: .date)
            .datePickerStyle(WheelDatePickerStyle())
            .labelsHidden()
            .disabled(viewModel.isDisable)
        }
    }

    struct ProjectEditDetailTextView: View {
        @ObservedObject var viewModel: ProjectModalViewModel

        var body: some View {
            TextEditor(text: $viewModel.detail)
                .font(.body)
                .frame(width: 680, height: 530, alignment: .center)
                .shadow(color: .gray, radius: 8, x: 0, y: 0)
                .padding(12)
                .disableAutocorrection(true)
                .disabled(viewModel.isDisable)
        }
    }
}

extension ProjectEditView {
    enum NameSpace {
        static let projectTitle = "Project Manager"
        static let editButton = "Edit"
        static let doneButton = "Done"
        static let titleSpaceHolder = "Title"
    }
}
