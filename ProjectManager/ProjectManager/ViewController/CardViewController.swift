//
//  CardViewController.swift
//  ProjectManager
//
//  Created by Kyungmin Lee on 2021/04/09.
//

import UIKit



class CardViewController: UIViewController {
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var descriptionsTextView: UITextView!
    @IBOutlet weak var deadlineDatePicker: UIDatePicker! {
        didSet {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                deadlineDatePicker.locale = appDelegate.locale
            }
        }
    }
    
    var card: Card?
    var isCardEditable: Bool {
        get {
            return _cardEditable
        }
        set(value) {
            _cardEditable = value
            titleTextView.isEditable = value
            descriptionsTextView.isEditable = value
            deadlineDatePicker.isUserInteractionEnabled = value
        }
    }
    
    private enum BarButtonTag: Int {
        case done
        case cancel
        case edit
        case save
    }
    private var _cardEditable: Bool = false
    private lazy var editButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(barButtonPressed(_:)))
        button.tag = BarButtonTag.edit.rawValue
        return button
    }()
    private lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(barButtonPressed(_:)))
        button.tag = BarButtonTag.save.rawValue
        button.tintColor = .systemRed
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let card = card {
            navigationBar.topItem?.leftBarButtonItem = editButton
            setupCard(card)
        }
    }
    
    @IBAction private func barButtonPressed(_ sender: Any) {
        guard let button = sender as? UIBarButtonItem,
              let barButtontag = BarButtonTag(rawValue: button.tag) else { return }
        
        switch barButtontag {
            case .done, .cancel:
                dismiss(animated: true, completion: nil)
            case .edit:
                navigationBar.topItem?.setLeftBarButton(saveButton, animated: true)
                isCardEditable = true
            case .save:
                navigationBar.topItem?.setLeftBarButton(editButton, animated: true)
                isCardEditable = false
        }
        
    }
    
    func setupCard(_ card: Card) {
        titleTextView.text = card.title
        if let descriptions = card.descriptions {
            descriptionsTextView.text = descriptions
        } else {
            descriptionsTextView.text = ""
        }
        if let deadlineDate = card.deadlineDate {
            deadlineDatePicker.date = deadlineDate
        }
    }
}
