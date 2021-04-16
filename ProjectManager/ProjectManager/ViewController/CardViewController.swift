//
//  CardViewController.swift
//  ProjectManager
//
//  Created by Kyungmin Lee on 2021/04/09.
//

import UIKit

protocol CardViewControllerDelegate {
    func cardViewController(_ cardViewController: CardViewController, card: Card)
}


class CardViewController: UIViewController {
    enum Mode {
        case addCard
        case presentCard
    }
    
    private enum BarButton: Int {
        case done = 0
        case cancel
        case edit
        
        var tag: Int {
            return self.rawValue
        }
    }
    
    private enum UIConstatns {
        static let titlePlaceHolder = "Title"
        static let descriptionsPlaceHolder = "할일 내용을 입력하세요. \n글자수는 1000자로 제한합니다."
    }
    
    @IBOutlet private weak var navigationBar: UINavigationBar!
    @IBOutlet private weak var titleTextView: UITextView!
    @IBOutlet private weak var descriptionsTextView: UITextView!
    @IBOutlet private weak var deadlineDatePicker: UIDatePicker! {
        didSet {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                deadlineDatePicker.locale = appDelegate.locale
            }
        }
    }
    @IBOutlet private weak var doneBarButton: UIBarButtonItem!
    @IBOutlet private var cancelBarButton: UIBarButtonItem!
    private lazy var editBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(barButtonPressed(_:)))
        button.tag = BarButton.edit.tag
        return button
    }()
    private lazy var dataManager: DataManager = {
        return DataManager.shared
    }()

    var delegate: CardViewControllerDelegate?
    var mode: Mode = .addCard
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
    private var _cardEditable: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextView()
        switch mode {
        case .addCard:
            isCardEditable = true
        case .presentCard:
            navigationBar.topItem?.leftBarButtonItem = editBarButton
            if let card = card {
                setupCard(card)
            }
        }
        
    }
    
    @IBAction private func barButtonPressed(_ sender: Any) {
        guard let button = sender as? UIBarButtonItem,
              let barButton = BarButton(rawValue: button.tag) else { return }
        
        switch mode {
        case .addCard:
            barButtonPressedOnAddCardMode(barButton: barButton)
        case .presentCard:
            barButtonPressedOnPresentCardMode(barButton: barButton)
        }
    }
    
    private func barButtonPressedOnAddCardMode(barButton: BarButton) {
        switch barButton {
        case .done:
            saveCard()
            dismiss(animated: true, completion: nil)
        case .cancel:
            dismiss(animated: true, completion: nil)
        case .edit:
            navigationBar.topItem?.setLeftBarButton(cancelBarButton, animated: true)
            isCardEditable = true
        }
    }
    
    private func barButtonPressedOnPresentCardMode(barButton: BarButton) {
        switch barButton {
        case .done:
            saveCard()
            dismiss(animated: true, completion: nil)
        case .cancel:
            dismiss(animated: true, completion: nil)
        case .edit:
            navigationBar.topItem?.setLeftBarButton(cancelBarButton, animated: true)
            isCardEditable = true
        }
    }
    
    func setupCard(_ card: Card) {
        titleTextView.textColor = .label
        titleTextView.text = card.title
        
        descriptionsTextView.textColor = .label
        if let descriptions = card.descriptions {
            descriptionsTextView.text = descriptions
        } else {
            descriptionsTextView.text = ""
        }
        
        
        if let deadlineDate = card.deadlineDate {
            deadlineDatePicker.date = deadlineDate
        }
    }
    
    func saveCard() {
        guard var editedCard = self.card else { return }
        guard let title = titleTextView.text,
              let descriptions = descriptionsTextView.text else { return }
        let deadline = Int(deadlineDatePicker.date.timeIntervalSince1970)

        editedCard.title = title
        editedCard.descriptions = descriptions
        editedCard.deadline = deadline
        
        dataManager.updateCard(with: editedCard)
        if let card = self.card {
            delegate?.cardViewController(self, card: card)
        }
    }
}

extension CardViewController: UITextViewDelegate {
    func setupTextView() {
        titleTextView.delegate = self
        titleTextView.text = CardViewController.UIConstatns.titlePlaceHolder
        titleTextView.textColor = .systemGray
        
        descriptionsTextView.delegate = self
        descriptionsTextView.text = CardViewController.UIConstatns.descriptionsPlaceHolder
        descriptionsTextView.textColor = .systemGray
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        switch textView {
        case titleTextView:
            if titleTextView.text == CardViewController.UIConstatns.titlePlaceHolder {
                titleTextView.text = ""
                titleTextView.textColor = .label
            }
        case descriptionsTextView:
            if descriptionsTextView.text == CardViewController.UIConstatns.descriptionsPlaceHolder {
                descriptionsTextView.text = ""
                descriptionsTextView.textColor = .label
            }
        default:
            break
        }
        return true
    }
}
