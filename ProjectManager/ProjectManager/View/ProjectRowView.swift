//
//  TodoRowView.swift
//  ProjectManager
//
//  Created by 박태현 on 2021/11/01.
//

import SwiftUI

struct ProjectRowView: View {
    @EnvironmentObject var projectListViewModel: ProjectListViewModel
    @State private var isModalViewPresented: Bool = false
    @State private var isLongPressed: Bool = false
    var project: Project

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(project.title)
                    .font(.title3)
                Text(project.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(3)
                Text(DateFormatter.convertDate(date: project.date))
                    .foregroundColor(project.isOutDated ? Color.red: Color.black)
                    .font(.footnote)
            }.lineLimit(1)
            Spacer()
        }.contentShape(Rectangle())
            .onTapGesture {
                isModalViewPresented.toggle()
            }
            .onLongPressGesture {
                isLongPressed.toggle()
            }
            .popover(isPresented: $isLongPressed,
                     attachmentAnchor: .point(.center)) {
                ForEach(projectListViewModel.transitionType(type: project.type), id: \.self) {
                    moveButton(type: $0)
                }
            }
            .sheet(isPresented: $isModalViewPresented) {
                ModalView(isDone: $isModalViewPresented,
                          modalViewType: .edit,
                          currentProject: project)
            }
    }
}

extension ProjectRowView {
    private func moveButton(type: ProjectStatus) -> some View {
            ZStack {
                Button {
                    projectListViewModel.action(.changeType(id: project.id, type: type))
                    isLongPressed.toggle()
                } label: {
                    Text("Move to \(type.description)")
                }
                .padding()
        }
    }
}

struct TodoRowView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectRowView(project: Project(title: "할일",
                               description: "오늘은 설거지를 할게여",
                               date: Date(), type: .todo))
                    .previewLayout(.sizeThatFits)
    }
}
