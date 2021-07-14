//
//  DetailViewController.swift
//  ProjectManager
//
//  Created by 강경 on 2021/06/29.
//

import UIKit

final class DetailViewController: UIViewController {
    private let dateFormatter = DateFormatter()
    private var viewStyle: DetailViewStyle = .add
    private var viewModel = DetailViewModel()
    private var tableViewType: TableViewType = .todo
    private var itemIndex: Int = 0
    
    @IBOutlet weak var newTitle: UITextField!
    @IBOutlet weak var newDate: UIDatePicker!
    @IBOutlet weak var newContent: UITextView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIBarButtonItem!
    
    @IBAction func clickDoneButton(_ sender: Any) {
        switch viewStyle {
        case .add:
            complete { (newCell: Memo, tableViewType: TableViewType) in
                viewModel.insert(
                    cell: newCell,
                    tableViewType: tableViewType
                )
            }
        case .edit:
            complete { (newCell: Memo, tableViewType: TableViewType) in
                viewModel.edit(
                    cell: newCell,
                    at: itemIndex,
                    tableViewType: tableViewType
                )
            }
        }
    }
    
    @IBAction func clickLeftButton(_ sender: Any) {
        switch viewStyle {
        case .add:
            cancelView()
        case .edit:
            makeTodoListItemEditable()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.post(
            name: Notification.Name(Strings.didDismissDetailViewNotification),
            object: nil,
            userInfo: nil
        )
    }
    
    func updateUI() {
        if let item = viewModel.tableItem() {
            newTitle.text = item.title
            newDate.date = dateFormatter.stringToDate(string: item.dueDate)
            newContent.text = item.content
        }
        
        if viewStyle == .edit {
            setEditView()
        }
    }
    
    func changeToEditMode() {
        viewStyle = .edit
    }
    
    // TODO: - 여기에 있는 TableViewModel 내쫓기
    // tableViewType으로 바꿔주자
    func setViewModel(
        tableViewModel: TableViewModel,
        index: Int
    ) {
        let newItem = tableViewModel.memoInfo(at: index)
        viewModel.setItem(newItem)
        tableViewType = tableViewModel.tableViewType
        itemIndex = index
    }
    
    private func setEditView() {
        leftButton.setTitle(
            Strings.editStyleTitleName,
            for: UIControl.State.normal
        )
        
        rightButton.isEnabled = false
        newTitle.isEnabled = false
        newDate.isEnabled = false
        newContent.isEditable = false
    }
}

// MARK: - Button Action
extension DetailViewController {
    private func complete(
        _ save: (_ newCell: Memo, _ tableViewType: TableViewType) -> Void
    ) {
        let newCell = Memo(
            id: "test",
            title: newTitle.text!,
            content: newContent.text,
            dueDate: dateFormatter.dateToString(date: newDate.date),
            memoType: "todo"
        )
        // TODO: - save이름 더 가독성 좋게 바꾸기
        save(newCell, tableViewType)
        
        NotificationCenter.default.post(
            name: Notification.Name(Strings.didDismissDetailViewNotification),
            object: nil,
            userInfo: nil
        )
        
        dismiss(
            animated: true,
            completion: nil
        )
    }
    
    private func makeTodoListItemEditable() {
        rightButton.isEnabled = true
        newTitle.isEnabled = true
        newDate.isEnabled = true
        newContent.isEditable = true
    }
    
    private func cancelView() {
        dismiss(
            animated: true,
            completion: nil
        )
    }
}
