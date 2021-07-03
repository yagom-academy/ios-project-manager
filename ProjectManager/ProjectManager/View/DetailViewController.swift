//
//  DetailViewController.swift
//  ProjectManager
//
//  Created by 강경 on 2021/06/29.
//

import UIKit

final class DetailViewController: UIViewController {
    static let dismissNotification = Notification.Name("didDismissDetailViewController")
    private let dateConverter = DateConverter()
    private var mode: DetailViewModeStyle = .addMode
    private var viewModel = DetailViewModel()
    private var itemIndex: Int = 0
    
    @IBOutlet weak var newTitle: UITextField!
    @IBOutlet weak var newDate: UIDatePicker!
    @IBOutlet weak var newContent: UITextView!
    @IBOutlet weak var leftButton: UIButton!
    
    @IBAction func clickDoneButton(_ sender: Any) {
        if mode == .addMode {
            addNewTODO()
        } else {
            cancel()
        }
    }
    
    @IBAction func clickLeftButton(_ sender: Any) {
        if mode == .addMode {
            cancel()
        } else {
            editTODO()
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
        
        if mode == .editMode {
            leftButton.setTitle("Edit", for: UIControl.State.normal)
        }
    }
    
    func changeToEditMode() {
        mode = .editMode
    }
    
    func setViewModel(tableViewModel: TableViewModel, index: Int) {
        itemIndex = index
        
        let newItem = tableViewModel.itemInfo(at: index)
        viewModel.setItem(newItem)
    }
    
    private func addNewTODO() {
        let title: String = newTitle.text!
        let date: Double = dateConverter.dateToNumber(date: newDate.date)
        let content: String = newContent.text
        
        // TODO: - dummy에 직접 접근하지 말고, ViewModel을 이용하여 처리하도록 하자
        dummy.append(
            TableItem(
                title: title,
                summary: content,
                date: date
            )
        )
        
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
    
    private func editTODO() {
        let title: String = newTitle.text!
        let date: Double = dateConverter.dateToNumber(date: newDate.date)
        let content: String = newContent.text
        
        // TODO: - dummy에 직접 접근하지 말고, ViewModel을 이용하여 처리하도록 하자
        dummy[itemIndex] = TableItem(
            title: title,
            summary: content,
            date: date
        )
        
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
    
    private func cancel() {
        dismiss(
            animated: true,
            completion: nil
        )
    }
}
