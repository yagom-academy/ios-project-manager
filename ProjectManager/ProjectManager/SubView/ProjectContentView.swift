//
//  ProjectContentView.swift
//  ProjectManager
//
//  Created by 재재, 언체인 on 2022/09/20.
//

import SwiftUI

struct ProjectContentView: View {
    @ObservedObject var viewModel: ProjectMainViewModel
    @State private var selectedProject: Project?
    @State private var isPopover = false

    var project: Project
    let today = Calendar.current.startOfDay(for: Date())

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(project.title ?? "")
                    .font(.title3.italic().bold())
                    .lineLimit(1)
                Text(project.detail ?? "")
                    .font(.body.monospacedDigit())
                    .foregroundColor(Color(.systemGray))
                    .lineLimit(3)
                Text(project.date ?? Date(), formatter: Date.formatter)
                    .font(.body.monospacedDigit())
                    .foregroundColor(project.date! >= today ? .black : .red)
            }
            Spacer()
        }
        .padding()
        .contentShape(Rectangle())
        .onTapGesture {
            selectedProject = project
        }
        .onLongPressGesture(minimumDuration: 1, perform: {
            viewModel.project = project
            isPopover = true
        })
        .sheet(item: $selectedProject) { ProjectEditView(viewModel: ProjectModalViewModel(project: $0),
                                                         projects: $viewModel.model,
                                                         selectedProject: $selectedProject
        )}
        .popover(isPresented: $isPopover) {
            VStack(alignment: .center) {
                Divider()
                PopoverButtonView(viewModel: viewModel, selectedProject: $selectedProject, isPopover: $isPopover)
            }
        }
    }

    struct PopoverButtonView: View {
        @ObservedObject var viewModel: ProjectMainViewModel
        @Binding var selectedProject: Project?
        @Binding var isPopover: Bool

        var destinationCandidates: [Status] {
            return Status.allCases.filter { $0 != viewModel.project?.status }
        }

        var body: some View {
            ForEach(destinationCandidates, id: \.self) { status in
                Button("move to \(status.rawValue)", action: {
                    isPopover = false
                    viewModel.model = viewModel.model.map({ project in
                        guard project.id == viewModel.project?.id else { return project }
                        var changedProject = project
                        changedProject.status = status
                        return changedProject
                    })
                })
                .frame(width: 150, height: 30, alignment: .center)
                .foregroundColor(Color("ZEZEColor"))
                Divider()
            }
        }
    }
}
