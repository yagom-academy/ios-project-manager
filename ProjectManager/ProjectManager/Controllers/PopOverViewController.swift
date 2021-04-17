import UIKit

protocol PopOverViewDelegate: AnyObject {
    func addThingToDataSource(_ popOverViewController: PopOverViewController, thing: Thing)
    func editThingToDataSource(_ popOverViewController: PopOverViewController, thing: Thing)
}

final class PopOverViewController: UIViewController {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.backgroundColor = .white
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        return stackView
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemBackground
        textField.placeholder = "Title"
        textField.clipsToBounds = false
        textField.layer.shadowOpacity = 0.5
        textField.layer.shadowRadius = 5.0
        textField.layer.shadowOffset = CGSize(width: 3, height: 3)
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.isEditable = true
        textView.clipsToBounds = false
        textView.layer.shadowRadius = 5.0
        textView.layer.shadowOpacity = 0.5
        textView.layer.shadowOffset = CGSize(width: 3, height: 3)
        return textView
    }()
    
    var delegate: PopOverViewDelegate?
    var thing: Thing?
    
    init(thing: Thing?) {
        super.init(nibName: nil, bundle: nil)
        
        if let thing = thing {
            configureEdit(with: thing)
        } else {
            configureAdd()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        if let thing = thing {
            configureEdit(with: thing)
        } else {
            configureAdd()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStackView()
        setConstraints()
    }
    
    private func setStackView() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(datePicker)
        stackView.addArrangedSubview(textView)
    }
    
    //Add Configure
    private func configureAdd() {
        navigationItem.title = PopOverNavigationItems.navigationTitle
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: PopOverNavigationItems.cancelButton, style: .plain, target: self, action: #selector(didTappedCancelButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: PopOverNavigationItems.doneButton, style: .plain, target: self, action: #selector(didTappedAddDoneButton))
    }
    
    //Edit Configure
    private func configureEdit(with thing: Thing) {
        navigationItem.title = PopOverNavigationItems.navigationTitle
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: PopOverNavigationItems.editButton, style: .plain, target: self, action: #selector(didTappedEditButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: PopOverNavigationItems.doneButton, style: .plain, target: self, action: #selector(didTappedEditDoneButton))
        textField.text = thing.title
        guard let dueDate = thing.dueDate else { return }
        datePicker.date = Date(timeIntervalSince1970: dueDate)
        textView.text = thing.detail
        self.thing = thing
        textField.isUserInteractionEnabled = false
        datePicker.isUserInteractionEnabled = false
        textView.isUserInteractionEnabled = false
    }
    
    @objc private func didTappedAddDoneButton() {
        let thing = Thing(id: UUID().uuidString, title: textField.text, description: textView.text, state: .todo, dueDate: datePicker.date.timeIntervalSince1970, updatedAt: "\(Date())")
        self.dismiss(animated: true) {
            self.delegate?.addThingToDataSource(self, thing: thing)
        }
    }
    
    @objc private func didTappedCancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTappedEditButton() {
        guard let contentView = self.navigationController?.viewControllers.last as? PopOverViewController else { return }
        contentView.textField.isUserInteractionEnabled = true
        contentView.datePicker.isUserInteractionEnabled = true
        contentView.textView.isUserInteractionEnabled = true
        
        contentView.textField.becomeFirstResponder()
    }
    
    @objc private func didTappedEditDoneButton() {
        guard let contentView = self.navigationController?.viewControllers.last as? PopOverViewController else { return }
        guard let thing = self.thing else {
            return
        }
        self.dismiss(animated: true) {
            thing.title = contentView.textField.text
            thing.detail = contentView.textView.text
            thing.dueDate = contentView.datePicker.date.timeIntervalSince1970
            self.delegate?.editThingToDataSource(self, thing: thing)
        }
    }
    
    private func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            textField.heightAnchor.constraint(equalToConstant: 42)
        ])
    }
}
