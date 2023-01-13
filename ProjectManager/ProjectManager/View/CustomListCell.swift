//
//  CustomListCell.swift
//  ProjectManager
//
//  Created by summercat on 2023/01/12.
//

import UIKit

final class CustomListCell: UICollectionViewListCell {
    private var item: Issue?
    
    override func updateConfiguration(using configuration: UICellConfigurationState) {
        var newConfiguration = CustomContentConfiguration().updated(for: configuration)
        newConfiguration.title = item?.title
        newConfiguration.body = item?.body
        newConfiguration.dueDate = item?.dueDate
        
        contentConfiguration = newConfiguration
    }
}
