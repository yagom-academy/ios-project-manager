import UIKit
import RxCocoa
import RxSwift

class DetailViewController: UIViewController {
    
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var datePicker: UIDatePicker!
    @IBOutlet private weak var descriptionTextView: UITextView!
    @IBOutlet private weak var rightBarButton: UIBarButtonItem!
    @IBOutlet private weak var leftBarButton: UIBarButtonItem!
    var viewModel: DetailViewModel?
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBindings()
    }
    
    private func setUpBindings() {
        let input = DetailViewModel.Input(
            didTapRightBarButton: rightBarButton.rx.tap.asObservable(),
            didTapLeftBarButton: leftBarButton.rx.tap.asObservable(),
            didChangeTitleText: titleTextField.rx.text.asObservable(),
            didChangeDatePicker: datePicker.rx.date.asObservable(),
            didChangeDescription: descriptionTextView.rx.text.asObservable())
        let output = viewModel?.transform(input: input)
        
        output?.isEditable.subscribe(onNext: { isEditable in
            if isEditable {
                self.titleTextField.isEnabled = true
                self.descriptionTextView.isEditable = true
                self.datePicker.isEnabled = true
                self.titleTextField.becomeFirstResponder()
            } else {
                self.titleTextField.isEnabled = false
                self.descriptionTextView.isEditable = false
                self.datePicker.isEnabled = false
            }
        }).disposed(by: disposeBag)
        
        output?.leftBarButtonText
            .bind(to: leftBarButton.rx.title)
            .disposed(by: disposeBag)
        
        output?.projectTitle
            .bind(to: titleTextField.rx.value)
            .disposed(by: disposeBag)
    
        output?.projectDate
            .bind(to: datePicker.rx.date)
            .disposed(by: disposeBag)
       
        output?.projectDescription
            .bind(to: descriptionTextView.rx.text)
            .disposed(by: disposeBag)
    
        output?.navigationTitle
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
    }
}
