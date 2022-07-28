//
//  PopOverViewController.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/11.
//

import RxSwift

final class PopOverViewController: UIViewController {
    private let popOverView = PopOverView()
    private var viewModel: PopOverViewModel?
    private let disposeBag = DisposeBag()
    
    init(with viewModel: PopOverViewModel) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
        
        setUpAttribute()
        setUpButtonAction()
        setUpButtonTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = popOverView
    }
    
    private func setUpAttribute() {
        guard let viewModel = viewModel else {
            return
        }
        
        modalPresentationStyle = .popover
        popoverPresentationController?.sourceView = viewModel.cell
        preferredContentSize = CGSize(width: 300, height: 100)
        popoverPresentationController?.permittedArrowDirections = .up
        
        popoverPresentationController?.sourceRect = CGRect(
            x: viewModel.cell.bounds.width * 0.5,
            y: viewModel.cell.bounds.minY,
            width: 30,
            height: 50
        )
    }
    
    private func setUpButtonTitle() {
        guard let (first, second) = viewModel?.getStatus() else {
            return
        }
        
        popOverView.setUpButtonTitle(first: first, second: second)
    }
    
    private func setUpButtonAction() {
        let firstButton = popOverView.firstButton
        let secondButton = popOverView.secondButton
        
        firstButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.viewModel?.moveCell(by: firstButton.titleLabel?.text)
                self?.dismiss(animated: true)
            }
            .disposed(by: disposeBag)

        secondButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.viewModel?.moveCell(by: secondButton.titleLabel?.text)
                self?.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
}
