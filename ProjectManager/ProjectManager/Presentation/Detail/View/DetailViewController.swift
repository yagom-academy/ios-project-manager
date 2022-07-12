//
//  DetailViewController.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/07.
//

import RxSwift
import RxCocoa
import RxKeyboard

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
    
    override func loadView() {
        view = modalView
    }
    
    override func viewDidLoad() {
        setUpModalView()
        setUpDetailNavigationItem()
        adjustViewLayoutByKeyboard()
    }
    
    private func setUpModalView() {
        modalView.compose(content: viewModel.content)
        modalView.isUserInteractionEnabled(false)
    }
    
    private func setUpDetailNavigationItem() {
        navigationController?.navigationBar.backgroundColor = .systemGray6
        navigationItem.title = viewModel.content.status.string
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
        navigationController?.navigationBar.backgroundColor = .systemGray6
        navigationItem.title = viewModel.content.status.string
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
                guard let self = self else {
                    return
                }
                let newContent = self.modalView.change(self.viewModel.content)
                self.viewModel.update(newContent)
                self.modalView.isUserInteractionEnabled(false)
                self.setUpDetailNavigationItem()
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
    
    private func adjustViewLayoutByKeyboard() {
        RxKeyboard.instance
            .visibleHeight
            .drive(onNext: { keyboardVisibleHeight in
                let height = keyboardVisibleHeight > 0 ? -keyboardVisibleHeight / 3 : 0
                self.modalView.frame.origin.y = height
            })
            .disposed(by: disposeBag)
    }
}
