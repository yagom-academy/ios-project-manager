import UIKit

class ProjectCell: UITableViewCell {
    static let nibName = "ProjectCell"
    static let identifier = "projectCell"
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    
    func configure(_ project: Project) {
        titleLabel.text = project.title == "" ? "New Project" : project.title
        descriptionLabel.text = project.description == "" ? "No additional text" : project.description
        dateLabel.text = Date.formattedString(project.date)
        changedDateColor(project.date)
    }
    
    private func changedDateColor(_ date: Date) {
        if date.isPastDeadline {
            dateLabel.textColor = .systemRed
        } else {
            dateLabel.textColor = .black
        }
    }
}
