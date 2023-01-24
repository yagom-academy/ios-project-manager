//  ProjectManager - ItemCountLabel.swift
//  created by zhilly on 2023/01/17

import UIKit

final class ItemCountLabel: UILabel {
    
    private enum Constant {
        static let maxCount: Int = 99
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect = .zero, count: Int) {
        self.init(frame: frame)
        text = convertToText(count)
        textColor = .white
        font = .preferredFont(forTextStyle: .headline)
        textAlignment = .center
        backgroundColor = .black
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.height / 2
    }
    
    private func convertToText(_ count: Int) -> String {
        return count > Constant.maxCount ? "\(Constant.maxCount)+" : "\(count)"
    }
}
