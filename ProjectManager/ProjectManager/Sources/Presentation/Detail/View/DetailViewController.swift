//
//  DetailViewController.swift
//  ProjectManager
//
//  Created by Ari on 2022/03/11.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var descriptionTextView: UITextView!
    var viewModel: DetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        navigationItem.title = viewModel?.project.status.rawValue
        titleTextField.text = viewModel?.project.title
        titleTextField.isEnabled = false
        descriptionTextView.text = viewModel?.project.description
        descriptionTextView.isEditable = false
        datePicker.date = viewModel?.project.date ?? Date()
        datePicker.isEnabled = false
    }
}
