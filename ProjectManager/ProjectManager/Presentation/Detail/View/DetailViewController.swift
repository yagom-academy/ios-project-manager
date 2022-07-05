//
//  DetailViewController.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/05.
//

import UIKit

final class DetailViewController: UIViewController {
    private let detailView = DetailView(frame: .zero)

    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
    }
}
