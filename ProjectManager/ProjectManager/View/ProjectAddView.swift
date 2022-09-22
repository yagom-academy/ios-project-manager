//
//  ProjectAddView.swift
//  ProjectManager
//
//  Created by 재재, 언체인  on 2022/09/12.
//

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
            ZStack {
                Rectangle()
                    .frame(width: 710, height: 80, alignment: .center)
                    .foregroundColor(Color("ZEZEColor"))
                HStack {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text(NameSpace.cancelButton)
                            .font(.title3.monospacedDigit().bold())
                            .foregroundColor(Color.white)
                    })
                    .padding(15)
                    Spacer()
                    Text(NameSpace.projectTitle)
                        .font(.title.monospacedDigit().bold())
                        .foregroundColor(Color.white)
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
                            .font(.title3.monospacedDigit().bold())
                            .foregroundColor(Color.white)
                            .padding(15)
                    })
                }
            }
        }
    }

    struct ProjectAddTitleTextView: View {
        @ObservedObject var viewModel: ProjectModalViewModel

        var body: some View {
            ZStack {
                Rectangle()
                    .frame(width: 655, height: 55, alignment: .center)
                    .foregroundColor(Color("BorderColor"))
                TextField(NameSpace.titleSpaceHolder, text: $viewModel.title)
                    .padding()
                    .frame(width: 650, height: 50, alignment: .center)
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
                    .fill(Color("BorderColor"))
                    .frame(width: 685, height: 535, alignment: .center)
                if viewModel.detail.isEmpty {
                    TextEditor(text: $viewModel.placeholder)
                        .frame(width: 680, height: 530, alignment: .center)
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
        static let projectTitle = "PROJECT MANAGER"
        static let cancelButton = "CANCEL"
        static let doneButton = "DONE"
        static let titleSpaceHolder = "Title"
    }
}
