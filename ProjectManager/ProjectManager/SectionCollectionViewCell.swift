//
//  SectionCollectionViewCell.swift
//  ProjectManager
//
//  Created by 강인희 on 2021/03/10.
//

import UIKit

class SectionCollectionViewCell: UICollectionViewCell {
    static let identifier = "SectionCollectionViewCell"
    @IBOutlet weak var boardTableView: UITableView!
    
    override func awakeFromNib() {
        registerXib()
    }
    
    private func registerXib(){
        let nibName = UINib(nibName: BoardTableViewCell.identifier, bundle: nil)
        boardTableView.register(nibName, forCellReuseIdentifier: BoardTableViewCell.identifier)
    }
}
extension SectionCollectionViewCell: UITableViewDelegate {

}
extension SectionCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoardTableViewCell.identifier) else {
            return UITableViewCell()
        }
       
        return cell
    }
}
