//
//  DoneTableView.swift
//  ProjectManager
//
//  Created by 임성민 on 2021/03/17.
//

import UIKit

final class DoneTableView: ThingTableView {
        
    //MARK: - Init
    
    override init() {
        super.init()
        tableHeaderView = ThingTableHeaderView(height: 50, title: Strings.doneTitle)
        NotificationCenter.default.addObserver(self, selector: #selector(setList(_:)), name: NSNotification.Name("broadcastdone"), object: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tableHeaderView = ThingTableHeaderView(height: 50, title: Strings.doneTitle)
        NotificationCenter.default.addObserver(self, selector: #selector(setList(_:)), name: NSNotification.Name("broadcastdone"), object: nil)
    }
    
    @objc func setList(_ notification: NSNotification) {
        if let userInfo = notification.userInfo,
           let list = userInfo[Strings.doneState] as? [Thing] {
            self.list = list
        }
    }
    
}
