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

        firstCollectionView.delegate = self
        secondCollectionView.delegate = self
        thirdCollectionView.delegate = self
    }
    
    private func setNavigation() {
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(goToAddTodoViewController))
    }
    
    @objc private func goToAddTodoViewController() {
        didTapAddButton(with: firstCollectionView)
    }
}

extension ViewController {
    func didTapAddButton(with collectionView: ListCollectionView) {
        let addTodoViewController = AddTodoViewController(collectionView: collectionView)
        addTodoViewController.modalPresentationStyle = .formSheet
        self.present(UINavigationController(rootViewController: addTodoViewController), animated: true, completion: nil)
    }
}

extension ViewController: UICollectionViewDelegate {
    //MARK:- Cell 터치 시, 상세 내용 표시
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let collectionView = collectionView as? ListCollectionView else { return }
        let descriptionViewController = UINavigationController(rootViewController: AddTodoViewController(collectionView: collectionView))
        descriptionViewController.modalPresentationStyle = .formSheet
        self.present(descriptionViewController, animated: true) {
            guard let presentedContentView = descriptionViewController.viewControllers.last as? AddTodoViewController else { return }
            presentedContentView.textField.isUserInteractionEnabled = false
            presentedContentView.datePicker.isUserInteractionEnabled = false
            presentedContentView.textView.isUserInteractionEnabled = false
        }
    }
}
