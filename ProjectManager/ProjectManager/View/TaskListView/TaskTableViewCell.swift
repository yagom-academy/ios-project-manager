import UIKit

final class TaskTableViewCell: UITableViewCell {
    var task: Task?
    var popoverPresenter: TaskListViewController!
    var taskListViewModel: TaskListViewModelProtocol!
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    override func prepareForReuse() {
        dateLabel.textColor = .black
        task = nil
    }
    
    func setup(with task: Task?, popoverPresenter: TaskListViewController, viewModel: TaskListViewModelProtocol) {
        self.task = task
        self.popoverPresenter = popoverPresenter
        self.taskListViewModel = viewModel
        
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
    
    // LongPress 제스처 처리 
    // 방법-1 TaskListViewController에서 처리 - 3개 tableView에 개별 적용해야 하므로 중복코드 발생
    // 방법-2 Cell에서 처리 - Cell은 ViewController 및 ViewModel 둘다 몰라서 ViewControlle에게 받아와야 함
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
        let titleOfOptions = processStatusChangeOptions
            .map { "Move To \($0.description)"  }
        
        let option1Action = UIAlertAction(title: titleOfOptions[safe: 0], style: .default) { [weak self] _ in
            self?.taskListViewModel.edit(task: (self?.task!)!, newProcessStatus: processStatusChangeOptions[safe: 0]!)
        }
        let option2Action = UIAlertAction(title: titleOfOptions[safe: 1], style: .default) { [weak self] _ in
            self?.taskListViewModel.edit(task: (self?.task!)!, newProcessStatus: processStatusChangeOptions[safe: 1]!)
        }

        let alert = AlertFactory().createAlert(style: .actionSheet, actions: option1Action, option2Action)
        let alertPopover = alert.popoverPresentationController
        alertPopover?.sourceView = self
        popoverPresenter.present(alert, animated: true)
    }
}
