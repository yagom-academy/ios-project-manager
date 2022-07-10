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
        detailView.setViewContents(list)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let detailView = DetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = detailView
    }
}
