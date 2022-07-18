//
//  PopOverViewController.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/11.
//

import RxSwift

final class PopOverViewController: UIViewController {
    private let popOverView = PopOverView()
    private let viewModel: PopOverViewModel
    private let disposeBag = DisposeBag()
    
    init(cell: ProjectCell) {
        viewModel = PopOverViewModel(cell: cell)
        super.init(nibName: nil, bundle: nil)
        
        setUpAttribute(cell)
        setUpButtonAction(cell)
        setUpButtonTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = popOverView
    }
    
    private func setUpAttribute(_ cell: ProjectCell) {
        modalPresentationStyle = .popover
        popoverPresentationController?.sourceView = cell
        preferredContentSize = CGSize(width: 300, height: 100)
        popoverPresentationController?.permittedArrowDirections = .up
        
        popoverPresentationController?.sourceRect = CGRect(
            x: cell.bounds.width * 0.5,
            y: cell.bounds.minY,
            width: 30,
            height: 50
        )
    }
    
    private func setUpButtonTitle() {
        guard let (first, second) = viewModel.getStatus() else {
            return
        }
        
        popOverView.setUpButtonTitle(first: first, second: second)
    }
    
    private func setUpButtonAction(_ cell: ProjectCell) {
        let firstButton = popOverView.firstButton
        let secondButton = popOverView.secondButton
        
        firstButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                guard let status = ProjectStatus.convert(firstButton.titleLabel?.text) else {
                    return
                }
                
                self?.viewModel.changeConent(status: status)
                self?.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        secondButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                guard let status = ProjectStatus.convert(secondButton.titleLabel?.text) else {
                    return
                }
                
                self?.viewModel.changeConent(status: status)
                self?.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
}
