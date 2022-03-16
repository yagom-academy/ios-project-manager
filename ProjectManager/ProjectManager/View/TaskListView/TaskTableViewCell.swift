import UIKit

final class TaskTableViewCell: UITableViewCell {
    var task: Task?
    var popoverPresenter: TaskListViewController!
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    override func prepareForReuse() {
        dateLabel.textColor = .black
        task = nil
    }
    
    func setup(with task: Task?, popoverPresenter: TaskListViewController) {
        self.task = task
        self.popoverPresenter = popoverPresenter // 일단은;
        
        setupLabels()
        setupBackgroundView()
        setupLongPressGesture()
    }
    
    private func setupLabels() {
        titleLabel.text = task?.title
        bodyLabel.text = task?.body
        
        if let dueDate = task?.dueDate {
            let dateText = DateFormatter.convertToString(from: dueDate)
            dateLabel.text = dateText
        }
    }
    
    private func setupBackgroundView() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .systemBlue
        selectedBackgroundView = backgroundView
    }
    
    // TaskListViewController에서 처리하면 3개 tableView에 개별 적용해야 하므로 중복코드 발생
    // 그런데 ViewController도 모르고, ViewModel도 모르는 상황...
    private func setupLongPressGesture() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(didLongPressed))
        longPressRecognizer.numberOfTouchesRequired = 1
        longPressRecognizer.minimumPressDuration = 0.5
        
        contentView.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc func didLongPressed(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            print("longpressed")
            presentPopoverToChangeProcessStatus()
        }
    }
    
    func presentPopoverToChangeProcessStatus() {
        guard let currentProcessStatus = task?.processStatus else {
            print(TaskManagerError.invalidProcessStatus.description)
            return
        }

        let processStatusChangeOptions = currentProcessStatus.processStatusChangeOption
            .map { "Move To \($0.description)"  }
        let optionActions = processStatusChangeOptions.map { option in
            return UIAlertAction(title: option, style: .default, handler: nil) // TODO: Handler 구현
        }

        let alert = AlertFactory().createAlert(style: .actionSheet, actions: optionActions)
        let alertPopover = alert.popoverPresentationController
        alertPopover?.sourceView = self

        popoverPresenter.present(alert, animated: true)
    }
}
