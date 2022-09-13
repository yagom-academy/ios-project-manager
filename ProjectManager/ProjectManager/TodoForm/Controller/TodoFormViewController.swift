//
//  TodoFormViewController.swift
//  ProjectManager
//
//  Created by seohyeon park on 2022/09/12.
//

import UIKit

class TodoFormViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var descriptionTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpShadow()
    }

    @IBAction func didTapCancelButton(_ sender: Any) {
        self.dismiss(animated: true)
    }

    @IBAction func didTapDoneButton(_ sender: Any) {
        let data = RealmDatabaseModel(
            title: titleTextField.text ?? "",
            description: descriptionTextView.text ?? "",
            deadline: datePicker.date.description,
            state: TaskState.todo
        )

        TaskData.shared.databaseManager.createDatabase(data: data)
        NotificationCenter.default.post(name: NSNotification.Name("모델 추가"), object: nil)
        self.dismiss(animated: true)
    }

    private func setUpShadow() {
        titleTextField.layer.shadowColor = UIColor.black.cgColor
        titleTextField.layer.shadowOffset = CGSize(width: 0, height: 3)
        titleTextField.layer.shadowOpacity = 0.6

        descriptionTextView.layer.shadowColor = UIColor.black.cgColor
        descriptionTextView.layer.shadowOffset = CGSize(width: 0, height: 2)
        descriptionTextView.layer.shadowOpacity = 0.6
        descriptionTextView.layer.masksToBounds = false
    }
}
