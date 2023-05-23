//
//  ProjectManager - ProjectManagerViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class ProjectManagerViewController: UIViewController {
    private var projects = Projects.shared
    
    lazy var projectManagerCollectionView: UICollectionView = {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .horizontal
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .estimated(self.projectManagerCollectionView.frame.height/8))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                                   heightDimension: .estimated(self.projectManagerCollectionView.frame.height/8))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: .fixed(self.projectManagerCollectionView.frame.height/14), trailing: nil, bottom: nil)
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                                    heightDimension: .estimated(self.projectManagerCollectionView.frame.height/10))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [header]
            section.orthogonalScrollingBehavior = .continuous
            section.interGroupSpacing = (-self.projectManagerCollectionView.frame.height / 7) + 8
            
            return section
        }, configuration: configuration)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        collectionView.register(ProjectCell.self, forCellWithReuseIdentifier: "ProjectCell")
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .systemGray5
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureProjectManagerCollectionView()
        configureConstraint()
        configureTapGestureRecognizer()
        configureLongGestureRecognizer()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemGray6
        title = "Project Manager"
        
        let addProjectButton = UIBarButtonItem(barButtonSystemItem: .add,
                                               target: self,
                                               action: #selector(addProject))
        navigationItem.rightBarButtonItem = addProjectButton
        
        projectManagerCollectionView.dataSource = self
    }
    
    @objc
    private func addProject() {
        let rootViewController = AddProjectViewController()
        rootViewController.projectManagerViewController = self
        rootViewController.configureEditingStatus(isEditible: true)
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
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let status = Status(rawValue: section)
        
        return projects.list.filter { $0.status == status }.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let status = Status(rawValue: indexPath.section) else { return ProjectCell() }
        
        guard let cell = projectManagerCollectionView.dequeueReusableCell(withReuseIdentifier: "ProjectCell", for: indexPath) as? ProjectCell else { return ProjectCell() }
        
        
        let assignedProjects = projects.list.filter { $0.status == status }
        let project = assignedProjects[indexPath.item]
        
        cell.configureContent(title: project.title, body: project.body, date: "\(project.date)")
        cell.deleteRow = {
            guard let removeIndex = self.projects.list.firstIndex(where: { $0.id == project.id }) else { return }
            self.projects.list.remove(at: removeIndex)
            self.projectManagerCollectionView.reloadData()
        }
        
        cell.backgroundColor = .white
        cell.layer.borderWidth = 1
        cell.layer.borderColor = CGColor(gray: 0.5, alpha: 0.5)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "HeaderView",
                for: indexPath
              ) as? HeaderView else { return UICollectionReusableView() }
        
        guard let status = Status(rawValue: indexPath.section) else { return UICollectionReusableView() }
        
        let assignedProjects = projects.list.filter { $0.status == status }
        
        var countText = "\(assignedProjects.count)"
        
        if countText.count > 2 {
            countText = "99+"
        }
        
        header.configureContent(status: status, number: countText)
        
        switch countText.count {
        case 2:
            header.numberLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        case 3:
            header.numberLabel.widthAnchor.constraint(equalToConstant: 36).isActive = true
        default:
            header.numberLabel.widthAnchor.constraint(equalToConstant: 24).isActive = true
        }
        
        return header
    }
}

extension ProjectManagerViewController: UIGestureRecognizerDelegate {
    private func configureTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(gestureRecognizer:)))
        tapGesture.delegate = self
        projectManagerCollectionView.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func handleTap(gestureRecognizer: UITapGestureRecognizer) {
        let location = gestureRecognizer.location(in: projectManagerCollectionView)
        
        if gestureRecognizer.state == .ended {
            if let indexPath = projectManagerCollectionView.indexPathForItem(at: location) {
                let rootViewController = AddProjectViewController()
                rootViewController.projectManagerViewController = self
                rootViewController.configureEditingStatus(isEditible: false)
                
                guard let status = Status(rawValue: indexPath.section) else { return }
                
                let assignedProjects = projects.list.filter { $0.status == status }
                let project = assignedProjects[indexPath.item]
                rootViewController.configureProject(assignedProject: project)
                let navigationController = UINavigationController(rootViewController: rootViewController)
                navigationController.modalPresentationStyle = UIModalPresentationStyle.formSheet
                
                self.present(navigationController, animated: true, completion: nil)
            }
        }
    }
    
    private func configureLongGestureRecognizer() {
        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        longPressedGesture.minimumPressDuration = 1
        longPressedGesture.delegate = self
        longPressedGesture.delaysTouchesBegan = true
        projectManagerCollectionView.addGestureRecognizer(longPressedGesture)
    }
    
    @objc
    func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        let location = gestureRecognizer.location(in: projectManagerCollectionView)
        
        if gestureRecognizer.state == .ended {
            if let indexPath = projectManagerCollectionView.indexPathForItem(at: location) {
                let moveToDoing = UIMenuItem(title: "Move to DOING", action: #selector(moveToDoing))
                let moveToDone = UIMenuItem(title: "Move to DONE", action: #selector(moveToDone))
                let menuController = UIMenuController.shared
                menuController.menuItems = [moveToDoing, moveToDone]
                let menuLocation = CGRect(x: location.x, y: location.y, width: 0, height: 0)
                menuController.showMenu(from: self.view, rect: menuLocation)
            }
        }
    }
    
    @objc
    func moveToDoing() {
        print("Move to Doing")
    }
    
    @objc
    func moveToDone() {
        print("Move to Done")
    }
}
