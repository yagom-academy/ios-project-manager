//
//  DetailViewController.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/06.
//

import UIKit
import RxSwift
import RxCocoa

final class DetailViewController: UIViewController {
    private let viewModel: MainViewModel
    private var listItem: ListItem?
    
    init(viewModel:MainViewModel ,listItem: ListItem?) {
        self.viewModel = viewModel
        self.listItem = listItem
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
        detailView.setViewContents(listItem)
        bindButton()
    }
    
    private func bindButton() {
        detailView.doneButton.rx.tap
            .bind(onNext: { [weak self] in
                guard let self = self else {
                    return
                }
                if self.listItem == nil {
                    self.viewModel.creatList(listItem: ListItem(title: self.detailView.titleTextField.text ?? "",
                                                                body: self.detailView.bodyTextView.text ?? "",
                                                                deadline: self.detailView.deadlinePicker.date))
                }

                self.dismiss(animated: true)
            })
            .disposed(by: disposebag)
    }
}
