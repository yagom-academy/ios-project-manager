//
//  TaskContextMenuView.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/09.
//

import SwiftUI

struct TaskPopoverView<Label>: View where Label: View {
    typealias Action = () -> Void
    typealias LabelView = () -> Label
    
    let firstButtonAction: Action
    let firstButtonLabel: LabelView
    let secondsButtonAction: Action
    let secondsButtonLabel: LabelView
    
    init(
        firstButtonAction: @escaping Action,
        @ViewBuilder firstButtonLabel: @escaping LabelView,
        secondsButtonAction: @escaping Action,
        @ViewBuilder secondsButtonLabel: @escaping LabelView
    ) {
        self.firstButtonAction = firstButtonAction
        self.firstButtonLabel = firstButtonLabel
        self.secondsButtonAction = secondsButtonAction
        self.secondsButtonLabel = secondsButtonLabel
    }
    
    var body: some View {
        VStack {
            Button {
                firstButtonAction()
            } label: {
                firstButtonLabel()
            }
            Divider()
            Button {
                secondsButtonAction()
            } label: {
                secondsButtonLabel()
            }
        }
    }
}
