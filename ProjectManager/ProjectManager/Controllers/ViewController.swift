//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    let firstCollectionView = ListCollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout(), collectionType: .todo)
    let secondCollectionView = ListCollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout(), collectionType: .doing)
    let thirdCollectionView = ListCollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout(), collectionType: .done)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        stackView.frame = view.bounds
        
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(firstCollectionView)
        stackView.addArrangedSubview(secondCollectionView)
        stackView.addArrangedSubview(thirdCollectionView)

        firstCollectionView.dragDelegate = self
        firstCollectionView.dropDelegate = self
        secondCollectionView.dragDelegate = self
        secondCollectionView.dropDelegate = self
        thirdCollectionView.dragDelegate = self
        thirdCollectionView.dropDelegate = self
        firstCollectionView.dragInteractionEnabled = true
        secondCollectionView.dragInteractionEnabled = true
        thirdCollectionView.dragInteractionEnabled = true
    }
    
    private func setNavigation() {
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(goToAddTodoViewController))
    }
    
    @objc private func goToAddTodoViewController() {
        didTapAddButton(with: firstCollectionView)
    }
    
    private func deleteFromBefore(thing: Thing) {
        switch thing.state {
        case .todo:
            firstCollectionView.deleteDataSource(thing: thing)
        case .doing:
            secondCollectionView.deleteDataSource(thing: thing)
        case .done:
            thirdCollectionView.deleteDataSource(thing: thing)
        default:
            return
        }
    }
}

extension ViewController {
    func didTapAddButton(with collectionView: ListCollectionView) {
        let addTodoViewController = AddTodoViewController(collectionView: collectionView)
        addTodoViewController.modalPresentationStyle = .formSheet
        self.present(UINavigationController(rootViewController: addTodoViewController), animated: true, completion: nil)
    }
}

//MARK: - UICollectionViewDragDelegate -
extension ViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        guard let collectionView = collectionView as? ListCollectionView,
              let thing = collectionView.diffableDataSource.itemIdentifier(for: indexPath) else {
            return []
        }
        
        let itemProvider = NSItemProvider(object: thing)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        
        return [dragItem]
    }
}


//MARK: - UICollectionViewDropDelegate -
extension ViewController: UICollectionViewDropDelegate {
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        var dropProposal = UICollectionViewDropProposal(operation: .cancel)
        guard session.items.count == 1 else {
            return dropProposal
        }
        if collectionView.hasActiveDrag {
            dropProposal = UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        } else {
            dropProposal = UICollectionViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
        }
        return dropProposal
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        guard let collectionView = collectionView as? ListCollectionView else {
            return
        }
        
        let destinationIndexPath: IndexPath
        
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = collectionView.numberOfSections - 1
            let row = collectionView.numberOfItems(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        
        coordinator.session.loadObjects(ofClass: Thing.self) { [weak self] (items) in
            guard let self = self else { return }
            let thingItem = items as! [Thing]
            let thing = thingItem.first!
            let state = collectionView.collectionType
            
            self.deleteFromBefore(thing: thing)
            thing.state = state
            collectionView.reorderDataSource(destinationIndexPath: destinationIndexPath, thing: thing)

        }
    }
}
