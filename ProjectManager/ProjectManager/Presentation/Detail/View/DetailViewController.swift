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
    private let mainViewModel: MainViewModel
    private let viewModel: DetailViewModel
    private let disposeBag = DisposeBag()
    private let modalView = ModalView(frame: .zero)
    private let detailTitle: String
    
    init(title: String, content: ProjectContent, mainViewModel: MainViewModel) {
        self.mainViewModel = mainViewModel
        self.detailTitle = title
        self.viewModel = DetailViewModel(content: content)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = modalView
    }
    
    override func viewDidLoad() {
        bind()
        setUpDetailNavigationItem()
    }
    
    private func bind() {
        viewModel.content
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] content in
                self?.modalView.compose(content: content)
                self?.modalView.isUserInteractionEnabled(false)
            })
            .disposed(by: disposeBag)
    }
    
    private func setUpDetailNavigationItem() {
        navigationItem.title = detailTitle
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: nil,
            action: nil
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: nil,
            action: nil
        )
        didTapEditButton()
        didTapDoneButton()
    }
    
    private func setUpEditNavigationItem() {
        navigationItem.title = detailTitle
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: nil,
            action: nil
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: nil,
            action: nil
        )
        didTapEditButton()
        didTapSaveButton()
    }
    
    private func didTapEditButton() {
        navigationItem.leftBarButtonItem?.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.modalView.isUserInteractionEnabled(true)
                self?.setUpEditNavigationItem()
            }
            .disposed(by: disposeBag)
    }
    
    private func didTapSaveButton() {
        navigationItem.rightBarButtonItem?.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.modalView.isUserInteractionEnabled(false)
                self?.setUpDetailNavigationItem()
                
            }
            .disposed(by: disposeBag)
    }
    
    private func didTapDoneButton() {
        navigationItem.rightBarButtonItem?.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
    }
}
