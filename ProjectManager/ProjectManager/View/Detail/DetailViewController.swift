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
    private let listItem: ListItem?
    
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
                if self?.listItem == nil {
                    self?.createNewList()
                } else {
                    self?.editList()
                }
                
                self?.dismiss(animated: true)
            })
            .disposed(by: disposebag)
        
        detailView.leftButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.tapLeftButton()
            })
            .disposed(by: disposebag)
    }
    
    private func createNewList() {
        let listItem = ListItem(title: detailView.titleTextField.text ?? "",
                                body: detailView.bodyTextView.text ?? "",
                                deadline: detailView.deadlinePicker.date)
        viewModel.creatList(listItem: listItem)
    }
    
    private func editList() {
        guard var listItem = listItem else {
            return
        }

        listItem.title = detailView.titleTextField.text ?? ""
        listItem.body = detailView.bodyTextView.text ?? ""
        listItem.deadline = detailView.deadlinePicker.date
        
        viewModel.updateList(listItem: listItem)
    }
    
    private func tapLeftButton() {
        if detailView.leftButton.title == "Cancel" {
            self.dismiss(animated: true)
        }
        
        detailView.leftButton.title = "Cancel"
        detailView.changeEditable()
    }
}
