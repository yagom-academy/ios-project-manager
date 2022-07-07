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
        setInitialView(listType: list?.type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let detailView = DetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setInitialView(listType: ListType?) {
        let title = listType?.title ?? ListType.todo.title
        detailView.naviItem.title = title
        self.view = detailView
    }
}
