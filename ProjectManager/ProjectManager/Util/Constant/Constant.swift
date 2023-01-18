//
//  Constant.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/12.
//

import CoreGraphics
import UIKit

enum Constant {

    enum Number {

        static let maxCount: Int = 99
    }

    enum Text {

        static let navigationTitle: String = "Project Manager"
        static let plusButton: String = "+"
        static let doneButton: String = "Done"
        static let editButton: String = "Edit"
        static let cancelButton: String = "Cancel"
        static let toDoTitle: String = "TODO"
        static let doingTitle: String = "DOING"
        static let doneTitle: String = "DONE"
        static let deleteSwipeTitle: String = "Delete"
        static let moveToToDo: String = "Move to TODO"
        static let moveToDoing: String = "Move to DOING"
        static let moveToDone: String = "Move to DONE"
        static let titlePlaceHolder: String = "Title"
        static let overCount: String = "99+"
    }

    enum Style {

        static let stackViewSpacing: CGFloat = 8
        static let listCellSpacing: CGFloat = 8
        static let stackViewBottomInset: CGFloat = -28
        static let listTitleMargin: CGFloat = 8
        static let circleViewWidthPadding: CGFloat = 16
        static let circleViewHeightPadding: CGFloat = 4
    }

    enum Color {

        static let mainBackground: UIColor = .systemBackground
        static let listViewSpacing: UIColor = .systemGray3
        static let listBackground: UIColor = .systemGray5
        static let circleBackground: CGColor = UIColor.black.cgColor
        static let circleText: UIColor = .white
        static let descriptionLabel: UIColor = .systemGray
        static let overDue: UIColor = .systemRed
        static let cellBackground: UIColor = .white
    }
}
