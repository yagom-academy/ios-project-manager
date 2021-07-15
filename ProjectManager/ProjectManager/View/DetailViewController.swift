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
    private var itemId: String = ""
    
    @IBOutlet weak var newTitle: UITextField!
    @IBOutlet weak var newDate: UIDatePicker!
    @IBOutlet weak var newContent: UITextView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIBarButtonItem!
    
    @IBAction func clickDoneButton(_ sender: Any) {
        switch viewStyle {
        case .add:
            complete { (newCell: Memo) in
                viewModel.insert(memo: newCell)
            }
        case .edit:
            complete { (newCell: Memo) in
                viewModel.edit(cell: newCell)
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
            newDate.date = dateFormatter.stringToDate(
                string: item.dueDate,
                dateFormat: .ymd_hms
            )
            newContent.text = item.content
        }
        
        if viewStyle == .edit {
            setEditView()
        }
    }
    
    func changeToEditMode() {
        viewStyle = .edit
    }
    
    func setViewModel(cellInfo: CellInfo) {
        // FIX: - 필요없는 isDateColorRed 처리
        let itemInfo = cellInfo.itemInfo
        let memoTableViewCellModel = MemoTableViewCellModel(
            id: itemInfo.id,
            title: itemInfo.title,
            content: itemInfo.content,
            dueDate: itemInfo.dueDate,
            isDateColorRed: false
        )
        viewModel.setItem(memoTableViewCellModel)
        tableViewType = cellInfo.tableViewType
        itemId = itemInfo.id
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
        _ save: (_ newCell: Memo) -> Void
    ) {
        let newCell = Memo(
            id: itemId,
            title: newTitle.text!,
            content: newContent.text,
            dueDate: dateFormatter.dateToString(
                date: newDate.date,
                dateFormat: .ymd_hms
            ),
            memoType: tableViewType.rawValue
        )
        // TODO: - save이름 더 가독성 좋게 바꾸기
        save(newCell)
        
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
