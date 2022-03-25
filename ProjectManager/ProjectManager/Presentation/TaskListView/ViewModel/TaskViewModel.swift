import UIKit

protocol TaskViewModelInputProtocol {}

protocol TaskViewModelOutputProtocol {
    func changeDateLabelColorIfExpired(with: Date) -> UIColor
}

protocol TaskViewModelProtocol: TaskViewModelInputProtocol, TaskViewModelOutputProtocol {}

final class TaskViewModel: TaskViewModelProtocol {
    func changeDateLabelColorIfExpired(with date: Date) -> UIColor {
        let dayInSeconds: Double = 3600 * 24
        let yesterday = Date(timeIntervalSinceNow: -dayInSeconds)
        return date < yesterday ? .systemRed : .label
    }
}
