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
            didChangeTitleText: titleTextField.rx.text.changed.asObservable(),
            didChangeDatePicker: datePicker.rx.date.changed.asObservable(),
            didChangeDescription: descriptionTextView.rx.text.changed.asObservable())
        let output = viewModel?.transform(input: input)
        
        output?.isEditable
            .bind(to:
                titleTextField.rx.isEnabled.asObserver(),
                datePicker.rx.isEnabled.asObserver(),
                descriptionTextView.rx.isEditable.asObserver()
            )
            .disposed(by: disposeBag)
        
        output?.leftBarButtonText
            .bind(to: leftBarButton.rx.title)
            .disposed(by: disposeBag)
        
        output?.projectTitle
            .bind(to: titleTextField.rx.text)
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
