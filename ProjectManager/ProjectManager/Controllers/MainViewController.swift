//
//  ProjectManager - ViewController.swift
//  Created by Jusbug.
//  Copyright © yagom. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var todoCollectionView: UICollectionView!
    @IBOutlet weak var doingCollectionView: UICollectionView!
    @IBOutlet weak var doneCollectionView: UICollectionView!
    let coreDataManager = CoreDataManager.shared
    var todoItem: [Entity] = []
    var doingItem: [Entity] = []
    var doneItem: [Entity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitle()
        initDelegateAndDataSource()
        registerNib()
        updateTodoColletionView()
        notificationForUpdate()
        filterItemsByStatus()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTodoColletionView()
        filterItemsByStatus()
    }
    
    private func notificationForUpdate() {
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveNotification), name: NSNotification.Name("createdTodo"), object:  nil)
    }
    
    private func registerNib() {
        todoCollectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        doingCollectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        doneCollectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        todoCollectionView.register(UINib(nibName: "CollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        doingCollectionView.register(UINib(nibName: "CollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        doneCollectionView.register(UINib(nibName: "CollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
    }
    
    private func initDelegateAndDataSource() {
        todoCollectionView.dataSource = self
        todoCollectionView.delegate = self
        doingCollectionView.dataSource = self
        doingCollectionView.delegate = self
        doneCollectionView.dataSource = self
        doneCollectionView.delegate = self
    }
    
    @objc func didReceiveNotification() {
        updateTodoColletionView()
        coreDataManager.getAllEntity()
        print("Received")
    }
    
    func updateTodoColletionView() {
        coreDataManager.getAllEntity()
        DispatchQueue.main.async {
            self.todoCollectionView.reloadData()
            self.doingCollectionView.reloadData()
        }
    }
    
    private func filterItemsByStatus() {
        todoItem = coreDataManager.entities.filter { $0.status == Status.todo.rawValue }
        doingItem = coreDataManager.entities.filter { $0.status == Status.doing.rawValue }
        doneItem = coreDataManager.entities.filter { $0.status == Status.done.rawValue }
    }
    
    private func configureTitle() {
        self.navigationItem.title = "Project Manager"
    }
    
    @IBAction func didTapAddButton(_ sender: Any) {
        guard let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "secondViewController") else { return }
        
        secondVC.modalTransitionStyle = .coverVertical
        secondVC.modalPresentationStyle = .popover
        
        if let popover = secondVC.popoverPresentationController {
            popover.sourceView = self.view
            popover.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popover.permittedArrowDirections = []
        }
        
        self.present(secondVC, animated: true, completion: nil)
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case todoCollectionView:
            return todoItem.count
        case doingCollectionView:
            return doingItem.count
        case doneCollectionView:
            return doneItem.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        
        var entity: Entity?
        
        switch collectionView {
        case todoCollectionView:
            entity = todoItem[indexPath.row]
        case doingCollectionView:
            entity = doingItem[indexPath.row]
        case doneCollectionView:
            entity = doneItem[indexPath.row]
        default:
            break
        }
        
        if let entity = entity {
            cell.configureLabels(entity: entity)
        }
        
        return cell
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let doing = UIAlertAction(title: "Move to Doing", style: .default) { [weak self] action in
            guard let self = self else { return }
            
            // 선택된 아이템을 가져온다
            let entity = todoItem[indexPath.row]
            
            // 해당 아이템의 요소들을 바인딩 처리
            guard let title = entity.title, let body = entity.body, let duration = entity.duration else { return }
            
            // 해당 아이템을 가져와 doing으로 생성
            self.coreDataManager.createEntity(title: title, body: body, duration: duration, status: .doing)

            //
            coreDataManager.deleteEntity(entity: entity)
            
            updateTodoColletionView()
        }
        
        let done = UIAlertAction(title: "Move to Done", style: .default)
        
        let delete = UIAlertAction(title: "Delete", style: .destructive) { [weak self] action in
            guard let self = self else { return }
            let entity = self.coreDataManager.entities[indexPath.row]
            coreDataManager.deleteEntity(entity: entity)
            updateTodoColletionView()
        }
        
        actionSheet.addAction(doing)
        actionSheet.addAction(done)
        actionSheet.addAction(delete)
        
        if let cell = collectionView.cellForItem(at: indexPath) {
            actionSheet.popoverPresentationController?.sourceView = cell
            actionSheet.popoverPresentationController?.sourceRect = CGRect(
                x: cell.bounds.midX,
                y: cell.bounds.midY,
                width: 0,
                height: 0
            )
            actionSheet.popoverPresentationController?.permittedArrowDirections = indexPath.row == collectionView.numberOfItems(inSection: indexPath.section) - 1 ? .down : .up
        }
        
        
        present(actionSheet, animated: true, completion: nil)
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 10, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as? CollectionReusableView else { return UICollectionReusableView()}
            
            if collectionView == todoCollectionView {
                headerView.headerLabel.text = "TODO"
            } else if collectionView == doingCollectionView {
                headerView.headerLabel.text = "DOING"
            } else if collectionView == doneCollectionView {
                headerView.headerLabel.text = "DONE"
            }
            
            return headerView
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width - 10, height: 80)
    }
}
