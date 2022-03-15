import UIKit
import RxSwift
import RxCocoa


protocol WorkFormViewControllerDelegate: AnyObject {
    func removeSelectedWork()
}

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
    
    weak var delegate: WorkFormViewControllerDelegate?
    
    @IBOutlet weak private var rightBarButtonItem: UIBarButtonItem!
    @IBOutlet weak private var titleTextField: UITextField!
    @IBOutlet weak private var datePicker: UIDatePicker!
    @IBOutlet weak private var bodyTextView: UITextView!
    
    private var projectViewModel: ProjectViewModel?
    private let disposeBag = DisposeBag()
    private var passedWork: Work?
    
    convenience init?(coder: NSCoder, viewModel: ProjectViewModel) {
        self.init(coder: coder)
        self.projectViewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContent()
        setupRightBarButtonItem()
        setupTextField()
        setupDatePicker()
        setupTextView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        delegate?.removeSelectedWork()
    }
    
    func setupContent() {
        guard let selectedWork = projectViewModel?.selectedWork else { return }
        
        _ = selectedWork
            .subscribe(onNext: { [weak self] in
                self?.passedWork = $0
            })
    }
    
    @IBAction private func touchUpRightBarButton(_ sender: UIBarButtonItem) {
        if rightBarButtonItem.title == Content.doneTitle {
            if titleTextField.text == Content.isEmpty {
                titleTextField.text = Content.EmptyTitle
            }
            
            let work = Work(title: titleTextField.text, body: bodyTextView.text, dueDate: datePicker.date)
            
            projectViewModel?.addWork(work)
        } else if rightBarButtonItem.title == Content.editTitle {
            guard let passedWork = passedWork else { return }
            
            projectViewModel?.updateWork(
                passedWork,
                title: titleTextField.text,
                body: bodyTextView.text,
                date: datePicker.date,
                category: passedWork.category
            )
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func touchUpCancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    private func setupRightBarButtonItem() {
        if projectViewModel?.selectedWork == nil {
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
