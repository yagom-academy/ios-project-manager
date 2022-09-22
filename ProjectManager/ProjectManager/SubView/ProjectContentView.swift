//
//  ProjectContentView.swift
//  ProjectManager
//
//  Created by 재재, 언체인 on 2022/09/20.
//

import SwiftUI

struct ProjectContentView: View {
    @ObservedObject var viewModel: ProjectMainViewModel
    @State var selectedProject: Project?
    @State var isPopover = false

    var project: Project
    let today = Calendar.current.startOfDay(for: Date())

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }()

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(project.title ?? "")
                    .font(.title3.monospacedDigit().bold())
                Text(project.detail ?? "")
                    .font(.body.monospacedDigit())
                    .foregroundColor(Color(.systemGray))
                    .lineLimit(3)
                Text(project.date ?? Date(), formatter: dateFormatter)
                    .font(.body.monospacedDigit())
                    .foregroundColor(project.date! >= today ? .black : .red)
            }
            .padding()
        }
        .listRowInsets(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
        .frame(width: 410, alignment: .leading)
        .onTapGesture {
            selectedProject = project
        }
        .onLongPressGesture(minimumDuration: 1, perform: {
            viewModel.project = project
            isPopover = true
        })
        .sheet(item: $selectedProject) { ProjectEditView(viewModel: ProjectModalViewModel(project: $0), projects: $viewModel.model) }
        .popover(isPresented: $isPopover) {
            VStack(alignment: .center) {
                Divider()
                ForEach(Status.allCases
                    .filter { $0 != viewModel.project?.status }, id: \.self) { status in
                        Button("move to (status.rawValue)", action: {
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
}
