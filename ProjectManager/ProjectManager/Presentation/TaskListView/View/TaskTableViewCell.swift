import UIKit

final class TaskTableViewCell: UITableViewCell {
    private var task: Task?
    private var taskListViewModel: TaskListViewModelProtocol!
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    override func prepareForReuse() {
        dateLabel.textColor = .label
        task = nil
    }
    
    func update(with task: Task, viewModel: TaskListViewModelProtocol) {
        self.task = task
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
            dateLabel.textColor = taskListViewModel.changeDateLabelColorIfExpired(with: dueDate)
        }
    }
    
    private func setupBackgroundView() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .systemBlue
        selectedBackgroundView = backgroundView
    }
    
    private func setupLongPressGesture() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(didLongPressed))
        longPressRecognizer.numberOfTouchesRequired = 1
        longPressRecognizer.minimumPressDuration = 0.5
        contentView.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc private func didLongPressed(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            presentPopoverToChangeProcessStatus()
        }
    }
    
    private func presentPopoverToChangeProcessStatus() {
        guard let currentProcessStatus = task?.processStatus else {
            print(TaskManagerError.invalidProcessStatus.description)
            return
        }

        let processStatusChangeOptions = taskListViewModel.processStatusChangeOptions(of: currentProcessStatus)
        let titleOfOptions = taskListViewModel.title(of: processStatusChangeOptions)
        
        let option1Action = UIAlertAction(title: titleOfOptions[safe: 0], style: .default) { [weak self] _ in
            self?.taskListViewModel.edit(task: self!.task!, newProcessStatus: processStatusChangeOptions[safe: 0]!)
        }
        let option2Action = UIAlertAction(title: titleOfOptions[safe: 1], style: .default) { [weak self] _ in
            self?.taskListViewModel.edit(task: self!.task!, newProcessStatus: processStatusChangeOptions[safe: 1]!)
        }

        let alert = AlertFactory.createAlert(style: .actionSheet, actions: option1Action, option2Action)
        alert.popoverPresentationController?.sourceView = self
        
        taskListViewModel.presentPopover(with: alert)
    }
}
