//
//  SectionCollectionViewCell.swift
//  ProjectManager
//
//  Created by 강인희 on 2021/03/10.
//

import UIKit

protocol BoardTableViewCellDelegate: AnyObject {
    func tableViewCell(_ boardTableViewCell: BoardTableViewCell, didSelectAt index: Int, tappedCollectionViewCell: SectionCollectionViewCell)
}

class SectionCollectionViewCell: UICollectionViewCell {
    static let identifier = "SectionCollectionViewCell"
    @IBOutlet weak var boardTableView: UITableView!
   
    weak var delegate: BoardTableViewCellDelegate?
    
    let titles = ["title1","title2","title3","title4","title5"]
    let descriptions = [" storyboard file instead.UIKit separates the content of your view controllers from the way that content is presented and displayed onscreen. Presented view controllers are managed by an underlying presentation controller object, which manages the visual style used to display the view controller’s view. A presentation controller may do the following:Set the size of the presented view controller.Add custom views to change the visual appearance of the presented content.Supply transition animations for any of its custom views.Adapt the visual appearance of the presentation when changes occur in the app’s environment.UIKit provides presentation controllers for the standard presentation styles. When you set the presentation style of a view controller to UIModalPresentationCustom and provide an appropriate transitioning delegate, UIKit uses your custom presentation controller instead.", "storyboard file", "storyboard filestoryboard filestoryboard file"," storyboard file instead.UIKit separates the content of your view controllers from the way that content is presented and displayed onscreen. Presented view controllers are managed by an underlying presentation controller object, which manages ","Project Manager"]
    let dueDates = ["2020.12.12" , "2020.12.13", "2020.12.14", "2020.12.22", "2020.12.31"]
    
    override func awakeFromNib() {
        registerXib()
    }
    
    private func registerXib(){
        let nibName = UINib(nibName: BoardTableViewCell.identifier, bundle: nil)
        boardTableView.register(nibName, forCellReuseIdentifier: BoardTableViewCell.identifier)
    }
}
extension SectionCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? BoardTableViewCell else {
            return
        }

        self.delegate?.tableViewCell(selectedCell, didSelectAt: indexPath.row, tappedCollectionViewCell: self)
    }
}
extension SectionCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoardTableViewCell.identifier) as? BoardTableViewCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.text = titles[indexPath.row]
        cell.descriptionLabel.text = descriptions[indexPath.row]
        cell.dueDateLabel.text = dueDates[indexPath.row]
       
        return cell
    }
}
