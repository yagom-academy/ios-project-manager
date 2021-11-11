//
//  ProjectRowView.swift
//  ProjectManager
//
//  Created by 박태현 on 2021/11/01.
//

import SwiftUI

struct ProjectRowView: View {
    var viewModel: ProjectRowViewModel
    @State private var isModalViewPresented: Bool = false
    @State private var isLongPressed: Bool = false

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(viewModel.title)
                    .font(.title3)
                Text(viewModel.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(3)
                Text(viewModel.convertedDate)
                    .foregroundColor(viewModel.dateFontColor)
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
                ForEach(viewModel.transitionType, id: \.self) {
                    moveButton(type: $0)
                }
            }
            .sheet(isPresented: $isModalViewPresented) {
                ModalView(isDone: $isModalViewPresented,
                          modalViewType: .edit,
                          projectID: viewModel.id)
            }
    }
}

extension ProjectRowView {
    private func moveButton(type: ProjectStatus) -> some View {
            ZStack {
                Button {
                    viewModel.action(.changeType(type: type))
                    isLongPressed.toggle()
                } label: {
                    Text("Move to \(type.description)")
                }
                .padding()
        }
    }
}

