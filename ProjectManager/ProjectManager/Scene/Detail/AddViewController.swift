//
//  AddViewController.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/06.
//

import RxSwift
import RxCocoa

final class AddViewController: UIViewController {
    private let viewModel: DetailViewModel
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let detailView = DetailView()
    private var disposebag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        self.view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.setAddView()
        bindButton()
    }
    
    private func bindButton() {
        detailView.doneButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.createList()
                self?.dismiss(animated: true)
            })
            .disposed(by: disposebag)
        
        detailView.leftButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposebag)
    }
    
    private func createList() {
        let listItem = ListItem(title: detailView.titleTextField.text ?? "",
                                body: detailView.bodyTextView.text ?? "",
                                deadline: detailView.deadlinePicker.date)
        viewModel.creatList(listItem: listItem)
    }
}
