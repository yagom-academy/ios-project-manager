//
//  DetailViewController.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/06.
//

import UIKit

final class DetailViewController: UIViewController {
    private let viewModel: MainViewModel
    private var listItem: ListItem?
    
    init(viewModel:MainViewModel ,listItem: ListItem?) {
        self.viewModel = viewModel
        self.listItem = listItem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let detailView = DetailView()
    
    override func loadView() {
        super.loadView()
        self.view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.setViewContents(listItem)
    }
}
