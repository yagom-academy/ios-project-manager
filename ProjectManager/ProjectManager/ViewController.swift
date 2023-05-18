//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    
    enum Section: CaseIterable {
        case todo
        case doing
        case done
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Schedule>?
    
    let schedule = Schedule(title: "asd", detail: "asd", expirationDate: "asd")
    let schedule2 = Schedule(title: "sdf", detail: "sdf", expirationDate: "sdf")
    let schedule3 = Schedule(title: "sdf", detail: "sdf", expirationDate: "sdf")
    
    var schedules: [Schedule] = []
    func createSchedules() {
        for i in 0..<10 {
            schedules.append(Schedule(title: "\(i)", detail: "hi", expirationDate: "오늘"))
        }
    }
    lazy var schedules2 = [schedule2]
    lazy var schedules3 = [schedule3]
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: configureCompositionalLayout())
        
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = true
        collectionView.backgroundColor = .brown
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        createSchedules()
        configureUI()
        configureNavigationBar()
        configureDataSource()
        applySnapshot()
    }
    
    private func configureNavigationBar() {
        self.title = "ProjectManager"
    }
    
    private func configureCompositionalLayout() -> UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        return layout
    }
    
    private func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
            
        ])
    }
}

extension ViewController: UICollectionViewDelegate {
    
    private func configureDataSource() {
        
        self.collectionView.register(ScheduleCell.self, forCellWithReuseIdentifier: "cell")
        
        self.dataSource = UICollectionViewDiffableDataSource<Section, Schedule> (collectionView: self.collectionView) { (collectionView, indexPath, schedule) -> UICollectionViewListCell? in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ScheduleCell else { return nil }
            
            cell.configureUI()
            cell.configureLabel(schedule: schedule)
            
            return cell
        }
    }
    
    private func applySnapshot() {
        var  snapshot = NSDiffableDataSourceSnapshot<Section, Schedule>()
        snapshot.appendSections([.todo, .doing, .done])
        snapshot.appendItems(schedules, toSection: .todo)
        snapshot.appendItems(schedules2, toSection: .doing)
        snapshot.appendItems(schedules3, toSection: .done)
        self.dataSource?.apply(snapshot, animatingDifferences: true)
    }
}
