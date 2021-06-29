//
//  DetailViewController.swift
//  ProjectManager
//
//  Created by 강경 on 2021/06/29.
//

import UIKit

enum Mode {
    case addMode, editMode
}

class DetailViewController: UIViewController {
    private let dateConverter = DateConverter()
    private var mode: Mode = .addMode
    let viewModel = DetailViewModel()
    
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
    
    func updateUI() {
        if let item = viewModel.item {
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
    
    private func addNewTODO() {
        let title: String = newTitle.text!
        let date: Double = dateConverter.dateToNumber(date: newDate.date)
        let content: String = newContent.text
        
        let printString = """
            --- TODO 추가 ---
            title: \(title)
            date: \(date)
            content: \(content)
            ----------------
            """
        print(printString)
        
        dismiss(
            animated: true,
            completion: nil
        )
    }
    
    private func editTODO() {
        let title: String = newTitle.text!
        let date: Double = dateConverter.dateToNumber(date: newDate.date)
        let content: String = newContent.text
        
        let printString = """
            --- TODO 변경 ---
            title: \(title)
            date: \(date)
            content: \(content)
            ----------------
            """
        print(printString)
        
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
