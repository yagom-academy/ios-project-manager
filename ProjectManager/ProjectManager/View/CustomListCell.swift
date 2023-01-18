//
//  CustomListCell.swift
//  ProjectManager
//
//  Created by summercat on 2023/01/12.
//

import UIKit

final class CustomListCell: UICollectionViewListCell {
    var item: Issue?
    
    override func updateConfiguration(using configuration: UICellConfigurationState) {
        var newConfiguration = CustomContentConfiguration().updated(for: configuration)
        newConfiguration.status = item?.status
        newConfiguration.title = item?.title
        newConfiguration.body = item?.body
        newConfiguration.deadline = item?.deadline
        
        contentConfiguration = newConfiguration
        backgroundConfiguration?.backgroundColor = .systemBackground
    }
}
