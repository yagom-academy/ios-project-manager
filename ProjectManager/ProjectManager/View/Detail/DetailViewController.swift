//
//  DetailViewController.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/06.
//

import UIKit

final class DetailViewController: UIViewController {
    init(list: List?) {
        super.init(nibName: nil, bundle: nil)
        setInitialView(list: list)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let detailView = DetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = detailView
    }
    
    private func setInitialView(list: List?) {
        guard let list = list else {
            detailView.naviItem.title = ListType.todo.title
            return
        }
        detailView.naviItem.title = list.type.title
        detailView.cancleButton.title = "Edit"
        detailView.titleTextField.text = list.title
        detailView.deadlinePicker.date = list.deadline
        detailView.bodyTextView.text = list.body
    }
}
