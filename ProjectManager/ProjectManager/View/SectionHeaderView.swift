//
//  SectionHeaderView.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/11.
//

import UIKit

final class SectionHeaderView: UIView {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        return stackView
    }()

    private let sectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.font = .preferredFont(forTextStyle: .largeTitle)
        
        return label
    }()

    private let numberImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(stackView)
        configurelayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configurelayout() {
        stackView.addArrangedSubview(sectionLabel)
        stackView.addArrangedSubview(numberImageView)
    }

    func setupLabelText(section: String, number: Int, font: UIFont = .preferredFont(forTextStyle: .body)) {
        sectionLabel.text = section
        numberImageView.image = circleAroundDigit(number, diameter: 30, font: font)
    }
    
    private func circleAroundDigit(
        _ num: Int,
        diameter: CGFloat,
        font: UIFont
    ) -> UIImage {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let customString = NSAttributedString(
            string: String(num),
            attributes: [.font: font, .foregroundColor: UIColor.white, .paragraphStyle: paragraphStyle]
        )
        let imageRenderer = UIGraphicsImageRenderer(size: CGSize(width: diameter, height: diameter))
        
        return imageRenderer.image {icon in
            UIColor.black.setFill()
            icon.cgContext.fillEllipse(in: CGRect(
                x: 0,
                y: 0,
                width: diameter,
                height: diameter
            ))
            customString.draw(in: CGRect(
                x: 0,
                y: diameter / 2 - font.lineHeight / 2,
                width: diameter,
                height: diameter
            ))
        }
    }
}
