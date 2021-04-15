import UIKit

class PopOverViewController: UIViewController {
    
    var collectionView: ListCollectionView?
    var indexPath: IndexPath?
    
    init(collectionView: ListCollectionView, leftBarbuttonTitle: String, indexPath: IndexPath?) {
        super.init(nibName: nil, bundle: nil)
        self.setNavigation(leftBarButtonTitle: leftBarbuttonTitle)
        self.collectionView = collectionView
        self.indexPath = indexPath
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let stackView: UIStackView = {
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
    
    let textField: UITextField = {
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
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    let textView: UITextView = {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStackView()
        setAutoLayout()
    }
    
    private func setStackView() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(datePicker)
        stackView.addArrangedSubview(textView)
    }
    
    private func setNavigation(leftBarButtonTitle: String) {
        navigationItem.title = PopOverNavigationItems.navigationTitle
        if leftBarButtonTitle == PopOverNavigationItems.cancelButton {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: PopOverNavigationItems.cancelButton, style: .plain, target: self, action: #selector(didTappedCancelButton))
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: PopOverNavigationItems.doneButton, style: .plain, target: self, action: #selector(didTappedAddDoneButton))
        } else {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: PopOverNavigationItems.editButton, style: .plain, target: self, action: #selector(didTappedEditButton))
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: PopOverNavigationItems.doneButton, style: .plain, target: self, action: #selector(didTappedEditDoneButton))
        }
    }
    
    @objc private func didTappedAddDoneButton() {
//        let thing = Thing(id: 3, title: textField.text, description: textView.text, state: .todo, dueDate: datePicker.date.timeIntervalSince1970, updatedAt: NSTimeIntervalSince1970)
//        collectionView?.insertDataSource(thing: thing, state: .todo)
        self.dismiss(animated: true, completion: nil)
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
        guard let collectionView = self.collectionView,
              let indexPath = self.indexPath else { return }
        let thing: Thing = Thing(title: nil, description: nil, state: nil, dueDate: nil)
        self.dismiss(animated: true) {
            thing.title = contentView.textField.text
            thing.des = contentView.textView.text
            thing.dueDate = contentView.datePicker.date.timeIntervalSince1970
            collectionView.updateThing(indexPath: indexPath, thing: thing)
        }
    }
    
    private func setAutoLayout() {
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
