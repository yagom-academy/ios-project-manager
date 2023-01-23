//
//  CountLabel.swift
//  ProjectManager
//
//  Created by summercat on 2023/01/13.
//

import UIKit

// TODO: issue 생성/삭제 시 countlabel 업데이트 delegate
final class CountLabel: UILabel {
    enum Constant {
        enum Namespace {
            static let maxCount = 99
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect = .zero, count: Int) {
        self.init(frame: frame)
        self.text = Constant.Namespace.formatCount(count)
        font = .preferredFont(forTextStyle: .headline)
        backgroundColor = .systemFill
        textAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = bounds.size.height / 2
    }
}

private extension CountLabel.Constant.Namespace {
    static func formatCount(_ count: Int) -> String {
        return (count > CountLabel.Constant.Namespace.maxCount ?
                "\(CountLabel.Constant.Namespace.maxCount)+" : count.description)
    }
}
