import UIKit
import RxSwift
import RxCocoa


private enum Content {
    static let isEmpty = ""
    static let EmptyTitle = "제목을 입력해주세요"
    static let editTitle = "Edit"
    static let doneTitle = "Done"
}

private enum Design {
    static let shadowColor: CGColor = UIColor.black.cgColor
    static let shadowOffset = CGSize(width: 0, height: 5)
    static let shadowOpacity: Float = 0.3
    static let shadowRadius: CGFloat = 5.0
    
    static let textInputBackgroundColor = UIColor.white.cgColor
    static let textFieldLeftPadding: CGFloat = 10
}

final class WorkFormViewController: UIViewController {
    
    private var viewModel: WorkFormViewModel?
    private let disposeBag = DisposeBag()
    private var passedWork: Work?
    
    @IBOutlet weak var rightBarButtonItem: UIBarButtonItem!
    @IBOutlet weak private var titleTextField: UITextField!
    @IBOutlet weak private var datePicker: UIDatePicker!
    @IBOutlet weak private var bodyTextView: UITextView!
    
    convenience init?(coder: NSCoder, viewModel: ProjectViewModel) {
        self.init(coder: coder)
        self.viewModel = WorkFormViewModel(
            workMemoryManager: viewModel.workMemoryManager,
            todoList: viewModel.todoList,
            doingList: viewModel.doingList,
            doneList: viewModel.doneList
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRightBarButtonItem()
        setupTextField()
        setupDatePicker()
        setupTextView()
    }
    
    @IBAction private func touchUpDoneButton(_ sender: UIBarButtonItem) {
        if rightBarButtonItem.title == Content.doneTitle {
            titleTextField.text = Content.EmptyTitle
            
            let work = Work(title: titleTextField.text, body: bodyTextView.text, dueDate: datePicker.date)
            
            viewModel?.addWork(work)
        } else if rightBarButtonItem.title == Content.editTitle {
            guard let passedWork = passedWork else { return }
            
            viewModel?.updateWork(
                passedWork,
                title: titleTextField.text,
                body: bodyTextView.text,
                date: datePicker.date
            )
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func touchUpCancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    func setupContent(from work: Observable<Work?>) {
        _ = work
            .subscribe(onNext: { [weak self] in
                self?.passedWork = $0
            })
    }

    private func setupRightBarButtonItem() {
        if passedWork?.title == nil {
            rightBarButtonItem.title = Content.doneTitle
        } else {
            rightBarButtonItem.title = Content.editTitle
        }
    }
    
    private func setupTextField() {
        configureTextFieldContent()
        configureTextFieldShadow()
        configureTextFieldLeftView()
    }
    
    private func configureTextFieldContent() {
        if passedWork?.title != nil {
            titleTextField.text = passedWork?.title
        }
    }
    
    private func configureTextFieldShadow() {
        titleTextField.layer.backgroundColor = Design.textInputBackgroundColor
        makeShadow(for: titleTextField)
    }
    
    private func configureTextFieldLeftView() {
        let leftView = UIView(frame: CGRect(
            x: .zero,
            y: .zero,
            width: Design.textFieldLeftPadding,
            height: titleTextField.frame.height
        ))
        titleTextField.leftView = leftView
        titleTextField.leftViewMode = .always
    }
    
    private func setupDatePicker() {
        configureDatePickerContent()
    }
    
    private func configureDatePickerContent() {
        if let date = passedWork?.dueDate {
            datePicker.date = date
        }
    }
    
    private func setupTextView() {
        configureTextViewContent()
        configureTextViewShadow()
    }
    
    private func configureTextViewContent() {
        if passedWork?.body != nil {
            bodyTextView.text = passedWork?.body
        }
    }
    
    private func configureTextViewShadow() {
        bodyTextView.layer.masksToBounds = false
        bodyTextView.layer.backgroundColor = Design.textInputBackgroundColor
        makeShadow(for: bodyTextView)
    }
    
    private func makeShadow(for view: UIView) {
        view.layer.shadowColor = Design.shadowColor
        view.layer.shadowOffset = Design.shadowOffset
        view.layer.shadowOpacity = Design.shadowOpacity
        view.layer.shadowRadius = Design.shadowRadius
    }
    
}
