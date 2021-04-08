import UIKit

class DetailViewController: UIViewController {
    
    var isEdit: Bool = false
    var todo: Todo? = nil
    var index: Int = 0
    var tableViewName: String? = nil
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        addShadow(textField)
        textField.backgroundColor = .white
        textField.placeholder = "Title"
        textField.isUserInteractionEnabled = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.isUserInteractionEnabled = true
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        addShadow(textView)
        textView.isEditable = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureConstraints()
        configureNavigationBar()
    }
    
    static private func addShadow(_ view: UIView) {
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowRadius = 2
        view.layer.borderWidth = 0.25
        view.layer.shadowOpacity = 0.5
        view.layer.masksToBounds = false
    }
    
    private func changeToEditable() {
            titleTextField.isUserInteractionEnabled = true
            datePicker.isUserInteractionEnabled = true
            descriptionTextView.isEditable = true
        }
    
    private func changeToUneditable() {
          titleTextField.isUserInteractionEnabled = false
          datePicker.isUserInteractionEnabled = false
          descriptionTextView.isEditable = false
      }
    
    @objc private func touchUpEditButton() {
           navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(touchUpCancelButton))
           changeToEditable()
       }
       
       @objc private func touchUpDoneButton() {
           if let title = titleTextField.text, let description = descriptionTextView.text  {
               let deadline = datePicker.date.timeIntervalSince1970
               let todo = Todo(title: title, description: description, deadline: deadline)
               if isEdit {
                   if tableViewName == String.todo {
                       Todos.common.todoList[index] = todo
                   } else if tableViewName == String.doing {
                       Todos.common.doingList[index] = todo
                   } else {
                       Todos.common.doneList[index] = todo
                   }
               } else {
                   Todos.common.todoList.append(todo)
               }
           }
           NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadView"), object: nil)
           dismiss(animated: true, completion: nil)
       }
       
       @objc private func touchUpCancelButton() {
           dismiss(animated: true, completion: nil)
       }
    
    private func configureNavigationBar() {
            if isEdit {
                navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(touchUpEditButton))
            } else {
                navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(touchUpCancelButton))
            }
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector (touchUpDoneButton))
            title = String.todo
        }

    private func configureConstraints() {
           let safeArea = view.safeAreaLayoutGuide
           view.backgroundColor = .white
           view.addSubview(titleTextField)
           view.addSubview(datePicker)
           view.addSubview(descriptionTextView)
           
           NSLayoutConstraint.activate([
               titleTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
               titleTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
               titleTextField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
               titleTextField.heightAnchor.constraint(equalToConstant: 50),
               
               datePicker.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
               datePicker.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
               datePicker.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10),
               
               descriptionTextView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
               descriptionTextView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
               descriptionTextView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 10),
               descriptionTextView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10),
           ])
       }
   }
