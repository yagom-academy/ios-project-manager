//
//  PopoverViewController.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/08.
//

import UIKit
import RxSwift
import RxCocoa

final class PopoverViewController: UIViewController {
    private let popoverView = PopoverView(frame: .zero)
    
    private let viewModel = PopoverViewModel()
    private let disposeBag = DisposeBag()
    weak var delegate: DataReloadable?
    var task: Task?
    
    override func loadView() {
        super.loadView()
        view = popoverView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind() {
        guard let task = task else {
            return
        }

        popoverView.moveToToDoButton.rx.tap
            .subscribe { [weak self] _ in
                self?.viewModel.moveButtonTapped(task, to: .todo)
            }
            .disposed(by: disposeBag)
        
        popoverView.moveToDoingButton.rx.tap
            .subscribe { [weak self] _ in
                self?.viewModel.moveButtonTapped(task, to: .doing)
            }
            .disposed(by: disposeBag)
        
        popoverView.moveToDoneButton.rx.tap
            .subscribe { [weak self] _ in
                self?.viewModel.moveButtonTapped(task, to: .done)
            }
            .disposed(by: disposeBag)
        
        viewModel.dismiss.asObservable()
            .bind(onNext: backToMain)
            .disposed(by: disposeBag)
    }
    
    private func backToMain() {
        dismiss(animated: true) { [weak self] in
            self?.delegate?.reloadData()
        }
    }
    
    func setPopoverAction() {
        guard let task = task else { return }
        switch task.taskType {
        case .todo:
            popoverView.moveToToDoButton.isHidden = true
        case .doing:
            popoverView.moveToDoingButton.isHidden = true
        case .done:
            popoverView.moveToDoneButton.isHidden = true
        }
    }
    
    

}
