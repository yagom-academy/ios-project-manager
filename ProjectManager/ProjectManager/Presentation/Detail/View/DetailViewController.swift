//
//  DetailViewController.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/07.
//

import UIKit
import RxSwift
import RxCocoa

final class DetailViewController: UIViewController {
    private let viewModel: DetailViewModel
    private let disposeBag = DisposeBag()
    private let modalView = ModalView(frame: .zero)
    private let detailTitle: String
    
    init(title: String, content: ProjectContent) {
        self.detailTitle = title
        self.viewModel = DetailViewModel(content: content)
        super.init(nibName: nil, bundle: nil)
        
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = modalView
    }
    
    override func viewDidLoad() {
        setUpNavigationItem()
    }
    
    private func setUpNavigationItem() {
        navigationItem.title = detailTitle
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(editRegistration)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(saveRegistration)
        )
    }
    
    @objc func editRegistration() {
        let next = UINavigationController(rootViewController: RegistrationViewController(viewModel: mainViewModel))
        
        next.modalPresentationStyle = .formSheet
        
        present(next, animated: true)
    }
    
    @objc func saveRegistration() {
        dismiss(animated: true, completion: nil)
    }
    
    private func bind() {
        viewModel.content
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] content in
                self?.modalView.compose(content: content)
                self?.modalView.disableUserInterface()
            })
            .disposed(by: disposeBag)
    }
}
