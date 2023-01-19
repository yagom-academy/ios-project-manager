//
//  LimitableTextView.swift
//  ProjectManager
//
//  Created by 애쉬 on 2023/01/19.
//

import UIKit

protocol LimitableTextView: UITextViewDelegate {
    override func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
}
