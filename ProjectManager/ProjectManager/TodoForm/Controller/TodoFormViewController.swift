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
    @IBOutlet weak var leftBarButton: UIBarButtonItem!
    @IBOutlet weak var rightBarButton: UIBarButtonItem!

    private var receivedModel: TaskModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpShadow()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(setUpForm),
            name: NSNotification.Name("모델 수정"),
            object: nil
        )
    }

    @IBAction func didTapCancelButton(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction func didTapDoneButton(_ sender: Any) {
        let data = RealmDatabaseModel(
            title: titleTextField.text ?? "",
            description: descriptionTextView.text ?? "",
            deadline: getCurrentDateTime(),
            state: TaskState.todo
        )

        TaskData.shared.databaseManager.createDatabase(data: data)
        notifyChangedModel()
    }

    private func notifyChangedModel() {
        NotificationCenter.default.post(name: NSNotification.Name("모델 리로드 예정"), object: nil)
        dismiss(animated: true)
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

    private func getCurrentDateTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd."
        return formatter.string(from: datePicker.date)
    }

    @objc private func setUpForm(_ notification: Notification) {
        guard let data = notification.object as? TaskModel else {
            return
        }

        receivedModel = data
        titleTextField.text = data.taskTitle
        descriptionTextView.text = data.taskDescription

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. dd."
        dateFormatter.timeZone = TimeZone(identifier: "UTC")

        guard let taskDate = dateFormatter.date(from: data.taskDeadline) else {
            return
        }

        datePicker.date = taskDate
        setUpDescriptionForm()
    }

    private func setUpDescriptionForm() {
        leftBarButton.title = "Edit"
        leftBarButton.action = #selector(didTapEditButton)
        rightBarButton.action = #selector(closeView)
    }

    @objc private func didTapEditButton() {
        guard var data = receivedModel else {
            return
        }

        data.taskTitle = titleTextField.text ?? ""
        data.taskDescription = descriptionTextView.text ?? ""
        data.taskDeadline = getCurrentDateTime()

        TaskData.shared.databaseManager.updateDatabase(data: data)
        notifyChangedModel()
    }

    @objc private func closeView() {
        dismiss(animated: false)
    }
}
