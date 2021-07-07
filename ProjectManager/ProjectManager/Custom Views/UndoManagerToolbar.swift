//
//  UndoManagerToolbar.swift
//  ProjectManager
//
//  Created by 김민성 on 2021/07/07.
//

import UIKit

class UndoManagerToolbar: UIToolbar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configure() {
        let undoButton = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: nil)
        let redoButton = UIBarButtonItem(barButtonSystemItem: .redo, target: self, action: nil)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        setItems([flexibleSpace, undoButton, redoButton], animated: true)
        undoButton.isEnabled = false
        redoButton.isEnabled = false
        
        barTintColor = .systemGray6
    }
}
