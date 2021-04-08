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

// ViewController에서 +버튼클릭시부터 collectionView를 들고다녀야함
// AddTodoViewController에서 CollectionView를 알고있어야하고
// 내가 어떤 collectionView에서 dataSource를 업데이트를 할지?

// thing 인스턴스를 ListCollectionView에 있는 updateDataSource라는 func에담아줘야함
// updateDataSource는 things라는 배열에 append하고 snapshot을 찍고 apply해줌

// cell에 어떤 내용이 표시되어야할지 configure (글렌에게 push요청)
