import UIKit

class HistoryTableViewCell: UITableViewCell {
    static let identifier = "HistoryCell"
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    func configureLabel(with index: Int) {
        self.title.text = String(describing: historyManager.historyContainer[index].0)
        self.subTitle.text = convertDateToString(date: historyManager.historyContainer[index].1)
    }
    
    private func convertDateToString(date: Date) -> String {
        let convertedDate: String
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MMM dd, yyyy h:mm:ss a"
        convertedDate = dateFormatter.string(from: date)
        
        return convertedDate
    }
}
