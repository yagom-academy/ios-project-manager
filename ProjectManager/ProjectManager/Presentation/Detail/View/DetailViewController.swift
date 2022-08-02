//
//  DetailViewController.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/07.
//

import RxSwift
import RxCocoa

private enum Constant {
    static let edit = "edit"
    static let done = "done"
    static let save = "save"
    static let cancel = "cancel"
}

private enum Mode {
    case display
    case edit
}

final class DetailViewController: UIViewController {
    private var viewModel: DetailViewModel?
    private let modalView = ModalView(frame: .zero)
    private let disposeBag = DisposeBag()
    private var mode: Mode = .display
    private var topConstraint: NSLayoutConstraint?
    
    init(with viewModel: DetailViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpAttribute()
        setUpLayout()
        setUpModalView()
        bind()
        modalView.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first, touch.view == self.view {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func setUpAttribute() {
        view.backgroundColor = .black.withAlphaComponent(0.5)
    }
    
    private func setUpLayout() {
        view.addSubview(modalView)
        
        modalView.translatesAutoresizingMaskIntoConstraints = false
        
        topConstraint = modalView.topAnchor.constraint(
            equalTo: view.topAnchor,
            constant: modalView.defaultTopConstant
        )
        
        NSLayoutConstraint.activate([
            modalView.widthAnchor.constraint(equalToConstant: ModalConstant.modalFrameWidth),
            modalView.heightAnchor.constraint(equalToConstant: ModalConstant.modalFrameHeight),
            modalView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topConstraint
        ].compactMap { $0 })
    }
    
    private func setUpModalView() {
        modalView.registerNotification()
        modalView.navigationBar.modalTitle.text = viewModel?.asContent().status.string
    }
    
    private func bind() {
        setUpDefaultUI()
        
        setUpLeftButton()
        setUpRightButton()
    }
    
    private func setUpDefaultUI() {
        modalView.navigationBar.leftButton.setTitle(Constant.edit, for: .normal)
        modalView.navigationBar.rightButton.setTitle(Constant.done, for: .normal)
        
        guard let project = self.viewModel?.read() else {
            return
        }
        self.modalView.compose(content: project)
        self.modalView.isUserInteractionEnabled(false)
    }
    
    private func setUpLeftButton() {
        let leftButton = modalView.navigationBar.leftButton
        
        leftButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                guard let self = self else {
                    return
                }
                
                switch self.mode {
                case .display:
                    self.didTapEditButton()
                case .edit:
                    self.didTapCancelButton()
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func setUpRightButton() {
        let rightButton = modalView.navigationBar.rightButton
        
        rightButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                guard let self = self else {
                    return
                }
                
                switch self.mode {
                case .display:
                    self.didTapDoneButton()
                case .edit:
                    self.didTapSaveButton()
                }
            }
            .disposed(by: disposeBag)
    }
}

extension DetailViewController {
    private func didTapEditButton() {
        modalView.navigationBar.leftButton.setTitle(Constant.cancel, for: .normal)
        modalView.navigationBar.rightButton.setTitle(Constant.save, for: .normal)
        
        modalView.isUserInteractionEnabled(true)
        
        mode = .edit
    }
    
    private func didTapDoneButton() {
        dismiss(animated: true, completion: nil)
    }
    
    private func didTapCancelButton() {
        modalView.navigationBar.leftButton.setTitle(Constant.edit, for: .normal)
        modalView.navigationBar.rightButton.setTitle(Constant.done, for: .normal)
        
        guard let project = self.viewModel?.read() else {
            return
        }
        
        self.modalView.compose(content: project)
        self.modalView.isUserInteractionEnabled(false)
        
        mode = .display
    }
    
    private func didTapSaveButton() {
        modalView.navigationBar.leftButton.setTitle(Constant.edit, for: .normal)
        modalView.navigationBar.rightButton.setTitle(Constant.done, for: .normal)
        
        guard let content = viewModel?.asContent() else {
            return
        }
        
        let newContent = modalView.change(content)
        viewModel?.update(newContent)
        modalView.isUserInteractionEnabled(false)
        
        mode = .display
    }
}

extension DetailViewController: ModalDelegate {
    func changeModalViewTopConstant(to constant: Double) {
        topConstraint?.constant = constant
        view.layoutIfNeeded()
    }
}
