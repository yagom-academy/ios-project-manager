//
//  CountLabel.swift
//  ProjectManager
//
//  Created by summercat on 2023/01/13.
//

import UIKit

final class CountLabel: UILabel {
    enum Constant {
        enum Namespace {
            static let maxCount = 99
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemFill
        font = .preferredFont(forTextStyle: .headline)
        textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = bounds.size.height / 2
        layer.masksToBounds = true
    }
}

private extension CountLabel.Constant.Namespace {
    static func formatLabelText(_ issueCount: Int) -> String {
        return (issueCount > CountLabel.Constant.Namespace.maxCount ?
                "\(CountLabel.Constant.Namespace.maxCount)+" : issueCount.description)
    }
}

extension CountLabel: IssueCountDelegate {
    func updateCountLabel(with issueCount: Int) {
        self.text = Constant.Namespace.formatLabelText(issueCount)
    }
}
