import UIKit

class HistoryTableViewCell: UITableViewCell {
    static let identifier = "HistoryCell"
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    func configureLabel(with index: Int) {
        self.title.text = historyManager.historyContainer[index].0
        self.subTitle.text = convertDateToString(date: historyManager.historyContainer[index].1)
    }
    
    private func convertDateToString(date: Date) -> String {
        let convertedDate: String
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        convertedDate = dateFormatter.string(from: date)
        
        return convertedDate
    }
}
