import UIKit

protocol MemoItemDelegate: AnyObject {
    func addMemo(_ item: Item)
}

class MemoInsertViewController: UIViewController {
    let titleTextField = UITextField()
    let datePicker = UIDatePicker()
    let textView = UITextView()
    weak var delegate: MemoItemDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureNavigationBar()
        configureUI()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "TODO"
        
        let rightBarButtonItem = UIBarButtonItem(systemItem: .done)
        navigationItem.rightBarButtonItem = rightBarButtonItem
        rightBarButtonItem.target = self
        rightBarButtonItem.action = #selector(saveMemo)
        
        let leftBarButtonItem = UIBarButtonItem(systemItem: .cancel)
        leftBarButtonItem.target = self
        leftBarButtonItem.action = #selector(dismissCurrentView)
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    @objc private func dismissCurrentView() {
        dismiss(animated: true)
    }
    
    @objc private func saveMemo() {
        let title = titleTextField.text ?? ""
        let date = datePicker.date.description
        let description = textView.text ?? ""
        
        let newItem = Item(title: title, description: description, date: date)
        delegate?.addMemo(newItem)
        dismiss(animated: true)
    }
    
    private func configureUI() {
        titleTextField.placeholder = "Title"
        view.addSubview(titleTextField)
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.backgroundColor = .systemGray6
        
        datePicker.preferredDatePickerStyle = .wheels
        view.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        textView.backgroundColor = .systemGray6
        view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 10),
            titleTextField.heightAnchor.constraint(equalToConstant: 50),
            titleTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            datePicker.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10),
            datePicker.heightAnchor.constraint(equalToConstant: 200),
            datePicker.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            textView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 10),
            textView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -10),
            textView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
        ])
    }
}
