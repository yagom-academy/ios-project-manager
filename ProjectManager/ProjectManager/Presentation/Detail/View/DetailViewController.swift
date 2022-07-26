//
//  DetailViewController.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/07.
//

import RxSwift
import RxCocoa

final class DetailViewController: UIViewController {
    private let viewModel: DetailViewModel
    private let modalView = ModalView(frame: .zero)
    private let disposeBag = DisposeBag()
    
    init(content: ProjectContent) {
        self.viewModel = DetailViewModel(content: content)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpAttribute()
        setUpLayout()
        setUpModalView()
        setUpDetailNavigationItem()
    }
    
    private func setUpAttribute() {
        view.backgroundColor = .black.withAlphaComponent(0.5)
    }
    
    private func setUpLayout() {
        view.addSubview(modalView)
        
        modalView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            modalView.widthAnchor.constraint(equalToConstant: 500),
            modalView.heightAnchor.constraint(equalToConstant: 600),
            modalView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            modalView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setUpModalView() {
        modalView.compose(content: viewModel.asContent())
        modalView.isUserInteractionEnabled(false)
    }
    
    private func setUpDetailNavigationItem() {
        modalView.navigationBar.modalTitle.text = viewModel.asContent().status.string
        modalView.navigationBar.leftButton.setTitle("edit", for: .normal)
        modalView.navigationBar.rightButton.setTitle("done", for: .normal)
        
        didTapEditButton()
        didTapDoneButton()
    }
    
    private func setUpEditNavigationItem() {
        modalView.navigationBar.modalTitle.text = viewModel.asContent().status.string
        modalView.navigationBar.leftButton.setTitle("cancel", for: .normal)
        modalView.navigationBar.rightButton.setTitle("save", for: .normal)
        
        didTapCancelButton()
        didTapSaveButton()
    }
    
    private func didTapEditButton() {
        let leftButton = modalView.navigationBar.leftButton
        
        leftButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.modalView.isUserInteractionEnabled(true)
                self?.setUpEditNavigationItem()
            }
            .disposed(by: disposeBag)
    }
    
    private func didTapDoneButton() {
        let rightButton = modalView.navigationBar.rightButton
        
        rightButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
    }
    
    private func didTapCancelButton() {
        let leftButton = modalView.navigationBar.leftButton
        
        leftButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                guard let self = self,
                      let project = self.viewModel.read() else {
                    return
                }
                self.modalView.compose(content: project)
                self.modalView.isUserInteractionEnabled(false)
                self.setUpDetailNavigationItem()
            }
            .disposed(by: disposeBag)
    }
    
    private func didTapSaveButton() {
        let rightButton = modalView.navigationBar.rightButton
        
        rightButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                guard let self = self else {
                    return
                }
                let newContent = self.modalView.change(self.viewModel.asContent())
                self.viewModel.update(newContent)
                self.modalView.isUserInteractionEnabled(false)
                self.setUpDetailNavigationItem()
            }
            .disposed(by: disposeBag)
    }
}
