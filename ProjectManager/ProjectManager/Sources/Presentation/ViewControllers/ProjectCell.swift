import UIKit

class ProjectCell: UITableViewCell {
    static let nibName = "ProjectCell"
    static let identifier = "projectCell"
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    
    func configure(_ project: Project) {
        titleLabel.text = project.title
        descriptionLabel.text = project.description
        dateLabel.text = Date.formattedString(project.date)
        changedDataColor(project.date)
    }
    
    private func changedDataColor(_ date: Date) {
        if date.isPastDeadline {
            titleLabel.textColor = .systemRed
        } else {
            titleLabel.textColor = .black
        }
    }
}
