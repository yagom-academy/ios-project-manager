//
//  DetailViewController.swift
//  ProjectManager
//
//  Created by 강경 on 2021/06/29.
//

import UIKit

final class DetailViewController: UIViewController {
    static let dismissNotification = Notification.Name(Strings.dismissNotification)
    private let dateConverter = DateConverter()
    private var viewStyle: DetailViewStyle = .add
    private var viewModel = DetailViewModel()
    private var itemIndex: Int = 0
    
    @IBOutlet weak var newTitle: UITextField!
    @IBOutlet weak var newDate: UIDatePicker!
    @IBOutlet weak var newContent: UITextView!
    @IBOutlet weak var leftButton: UIButton!
    
    @IBAction func clickDoneButton(_ sender: Any) {
        switch viewStyle {
        case .add:
            addTodoListItem()
        case .edit:
            cancelView()
        }
    }
    
    @IBAction func clickLeftButton(_ sender: Any) {
        switch viewStyle {
        case .add:
            cancelView()
        case .edit:
            editTodoListItem()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.post(
            name: DetailViewController.dismissNotification,
            object: nil,
            userInfo: nil
        )
    }
    
    func updateUI() {
        if let item = viewModel.tableItem() {
            newTitle.text = item.title
            newDate.date = dateConverter.numberToDate(number: item.date)
            newContent.text = item.summary
        }
        
        if viewStyle == .edit {
            leftButton.setTitle(
                Strings.editStyleTitle,
                for: UIControl.State.normal
            )
        }
    }
    
    func changeToEditMode() {
        viewStyle = .edit
    }
    
    func setViewModel(
        tableViewModel: TodoTableViewModel,
        index: Int
    ) {
        itemIndex = index
        
        let newItem = tableViewModel.itemInfo(at: index)
        viewModel.setItem(newItem)
    }
}

// MARK: - Button Action
extension DetailViewController {
    private func addTodoListItem() {
        let title: String = newTitle.text!
        let date: Double = dateConverter.dateToNumber(date: newDate.date)
        let content: String = newContent.text
        
        let newCell = TableItem(
            title: title,
            summary: content,
            date: date
        )
        viewModel.insert(cell: newCell)
        
        NotificationCenter.default.post(
            name: DetailViewController.dismissNotification,
            object: nil,
            userInfo: nil
        )
        
        dismiss(
            animated: true,
            completion: nil
        )
    }
    
    private func editTodoListItem() {
        let title: String = newTitle.text!
        let date: Double = dateConverter.dateToNumber(date: newDate.date)
        let content: String = newContent.text
        
        let editedCell = TableItem(
            title: title,
            summary: content,
            date: date
        )
        viewModel.edit(cell: editedCell, at: itemIndex)
        
        NotificationCenter.default.post(
            name: DetailViewController.dismissNotification,
            object: nil,
            userInfo: nil
        )
        
        dismiss(
            animated: true,
            completion: nil
        )
    }
    
    private func cancelView() {
        dismiss(
            animated: true,
            completion: nil
        )
    }
}
