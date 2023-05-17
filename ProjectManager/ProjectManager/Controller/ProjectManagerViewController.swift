//
//  ProjectManager - ProjectManagerViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class ProjectManagerViewController: UIViewController {
    
    let projectManagerCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(ProjectCell.self, forCellWithReuseIdentifier: "ProjectCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureProjectManagerCollectionView()
        configureConstraint()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        title = "Project Manager"
        
        let addProjectButton = UIBarButtonItem(barButtonSystemItem: .add,
                                             target: self,
                                             action: #selector(addProject))
        navigationItem.rightBarButtonItem = addProjectButton
        
        projectManagerCollectionView.dataSource = self
        projectManagerCollectionView.delegate = self
    }
    
    @objc
    private func addProject() {
        let rootViewController = AddProjectViewController()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.modalPresentationStyle = UIModalPresentationStyle.formSheet
        
        self.present(navigationController, animated: true, completion: nil)
    }
    
    private func configureProjectManagerCollectionView() {
        view.addSubview(projectManagerCollectionView)
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            projectManagerCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            projectManagerCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            projectManagerCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            projectManagerCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension ProjectManagerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = projectManagerCollectionView.dequeueReusableCell(withReuseIdentifier: "ProjectCell", for: indexPath) as? ProjectCell else { return ProjectCell() }
        
        cell.configureContent(data: Project(title: "시험용제목", body: "시험용내용", date: Date()))
        
        return cell
    }
    
    
}

extension ProjectManagerViewController: UICollectionViewDelegate {
    
}
