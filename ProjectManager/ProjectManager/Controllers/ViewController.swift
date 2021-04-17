//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    private let todoCollectionView = ListCollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout(), collectionType: .todo)
    private let doingCollectionView = ListCollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout(), collectionType: .doing)
    private let doneCollectionView = ListCollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout(), collectionType: .done)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        stackView.frame = view.bounds
        view.addSubview(stackView)
        collectionViewSetup()
    }
    
    private func setNavigation() {
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(presentPopOverViewController))
    }
    
    private func collectionViewSetup() {
        stackView.addArrangedSubview(todoCollectionView)
        stackView.addArrangedSubview(doingCollectionView)
        stackView.addArrangedSubview(doneCollectionView)
        
        dragAndDropSetup(todoCollectionView)
        dragAndDropSetup(doingCollectionView)
        dragAndDropSetup(doneCollectionView)
    }
    
    private func dragAndDropSetup(_ listCollectionView: ListCollectionView) {
        listCollectionView.delegate = self
        listCollectionView.dragDelegate = self
        listCollectionView.dropDelegate = self
        listCollectionView.dragInteractionEnabled = true
    }
    
    @objc private func presentPopOverViewController() {
        didTapAddButton(with: todoCollectionView)
    }
    
    private func deleteFromBefore(thing: Thing) {
        guard let state = thing.state else { return }
        switch state {
        case .todo:
            todoCollectionView.deleteDataSource(thing: thing)
        case .doing:
            doingCollectionView.deleteDataSource(thing: thing)
        case .done:
            doneCollectionView.deleteDataSource(thing: thing)
        }
    }
}

//MARK: - Thing Add / Edit 관련
extension ViewController {
    private func didTapAddButton(with collectionView: ListCollectionView) {
        let popOverViewController = PopOverViewController(thing: nil)
        popOverViewController.modalPresentationStyle = .formSheet
        popOverViewController.delegate = self
        self.present(UINavigationController(rootViewController: popOverViewController), animated: true, completion: nil)
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
            guard let thingItem = items as? [Thing],
                  let thing = thingItem.first else { return }
            let state = collectionView.collectionType
            
            self.deleteFromBefore(thing: thing)
            thing.state = state
            collectionView.reorderDataSource(destinationIndexPath: destinationIndexPath, thing: thing)

        }
    }
}

//MARK: - UICollectionViewDelegate -
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let collectionView = collectionView as? ListCollectionView,
              let thing = collectionView.diffableDataSource.itemIdentifier(for: indexPath) else {
            return
        }
        let popOverViewController = PopOverViewController(thing: thing)
        popOverViewController.delegate = self
        self.present(UINavigationController(rootViewController: popOverViewController), animated: true)
    }
}

extension ViewController: PopOverViewDelegate {
    func addThingToDataSource(_ popOverViewController: PopOverViewController, thing: Thing) {
        todoCollectionView.insertDataSource(thing: thing, state: .todo)
    }
    
    func editThingToDataSource(_ popOverViewController: PopOverViewController, thing: Thing) {
        guard let state = thing.state else { return }
        switch state {
        case .todo:
            todoCollectionView.updateThing(thing: thing)
        case .doing:
            doingCollectionView.updateThing(thing: thing)
        case .done:
            doneCollectionView.updateThing(thing: thing)
        }
    }
}
