//
//  ProjectManager - ViewController.swift
//  Created by Jusbug.
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var todoCollectionView: UICollectionView!
    @IBOutlet weak var doingCollectionView: UICollectionView!
    @IBOutlet weak var doneCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitle()
    }

    private func configureTitle() {
        self.navigationItem.title = "Projcet Manager"
    }
}
