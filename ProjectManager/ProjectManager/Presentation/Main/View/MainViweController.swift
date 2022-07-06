//
//  MainViweController.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/04.
//

import UIKit
import RxSwift
import RxCocoa

final class MainViweController: UIViewController {
    private let mainView = MainView(frame: .zero)
    
    private let disposeBag = DisposeBag()
    private let viewModel = MainViewModel()
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigationItem()
        
        bind()
    }
    
    private func setUpNavigationItem() {
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(presentDetailView)
        )
    }
    
    @objc func presentDetailView() {
        let next = UINavigationController(rootViewController: RegistrationViewController())
        
        next.modalPresentationStyle = .formSheet
        
        present(next, animated: true)
    }
    
    private func bind() {
        guard let saveButton = navigationItem.rightBarButtonItem else {
            return
        }
        
        let input = MainViewModel
            .Input(
                saveButtonTapEvent: saveButton.rx.tap.asObservable(),
                cellTapEvent: mainView.toDoTableView.rx.itemSelected.asObservable()
            )
        
        let output = viewModel.transform(input: input)
    }
}
