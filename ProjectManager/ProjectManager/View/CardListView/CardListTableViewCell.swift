//
//  CardListTableViewCell.swift
//  ProjectManager
//
//  Created by Derrick kim on 9/7/22.
//

import UIKit
import Then

final class CardListTableViewCell: UITableViewCell, ReuseIdentifying {
    private enum Const {
        static let stackViewSpacing = 5.0
        static let baseConstraint = 12.0
        static let layerCornerRadius = 30.0
        static let numberOfLines = 3
    }
    
    private let titleLabel = UILabel().then {
        $0.font = UIFont.preferredFont(forTextStyle: .title3)
        $0.setContentHuggingPriority(.defaultHigh,
                                     for: .vertical)
    }
    
    private let descriptionLabel = UILabel().then {
        $0.font = UIFont.preferredFont(forTextStyle: .body)
        $0.textColor = .systemGray3
        $0.numberOfLines = Const.numberOfLines
    }
    
    private let deadlineDateLabel = UILabel().then {
        $0.font = .preferredFont(forTextStyle: .callout)
        $0.setContentHuggingPriority(.defaultHigh,
                                     for: .vertical)
    }
    
    private lazy var rootStackView = UIStackView(
        arrangedSubviews: [titleLabel, descriptionLabel, deadlineDateLabel]).then {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.axis = .vertical
            $0.spacing = Const.stackViewSpacing
        }

    var model: CardModel?
    var viewModel: CardViewModel?
    var coodinator: CoordinatorProtocol?
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupDefault()
        setupLongGesture()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        descriptionLabel.text = nil
        deadlineDateLabel.text = nil
    }

    override func draw(_ rect: CGRect) {
        let separator = UIBezierPath()
        separator.move(to: CGPoint(x: 0, y: bounds.maxY))
        separator.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        separator.lineWidth = 20
        UIColor.systemGray6.setStroke()
        separator.stroke()
        separator.close()
    }

    func bindUI(_ model: CardEntity) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        deadlineDateLabel.text = model.deadlineDate
        deadlineDateLabel.textColor = model.isExpired ? .red : .black
    }
    
    private func setupDefault() {
        self.contentView.addSubview(rootStackView)
        backgroundColor = .white

        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor,
                                               constant: Const.baseConstraint),
            rootStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,
                                                  constant: -Const.baseConstraint),
            rootStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,
                                                   constant: Const.baseConstraint),
            rootStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,
                                                    constant: -Const.baseConstraint)
        ])
    }
}

extension CardListTableViewCell {
    private func setupLongGesture() {
        let longPressGesture = UILongPressGestureRecognizer()
        longPressGesture.minimumPressDuration = 1
        longPressGesture.addTarget(self,
                                   action: #selector(didTapTableViewCellLongPress))
        self.addGestureRecognizer(longPressGesture)
    }

    @objc private func didTapTableViewCellLongPress(_ guesture: UILongPressGestureRecognizer) {
        if guesture.state == .began {
            coodinator?.presentAlertActionSheet(createActionSheet())
        }
    }

    private func createActionSheet() -> UIAlertController {
        let alertViewController = UIAlertController(title: nil,
                                                    message: nil,
                                                    preferredStyle: .actionSheet)

        let (firstCard, secondCard) = distinguishCardType(of: model)

        alertViewController.modalPresentationStyle = .popover
        alertViewController.popoverPresentationController?.permittedArrowDirections = .up

        alertViewController.popoverPresentationController?.sourceView = self
        alertViewController.popoverPresentationController?.sourceRect = CGRect(x: self.contentView.frame.midX,
                                                                               y: self.contentView.frame.midY,
                                                                               width: 1,
                                                                               height: 1)
        let firstAction = UIAlertAction(title: firstCard.moveToAnotherSection,
                                        style: .default) { [weak self] _ in
            self?.viewModel?.move(self?.model,
                                  to: firstCard)
        }

        let secondAction = UIAlertAction(title: secondCard.moveToAnotherSection,
                                         style: .default) { [weak self] _ in
            self?.viewModel?.move(self?.model,
                                  to: secondCard)
        }

        alertViewController.addAction(firstAction)
        alertViewController.addAction(secondAction)

        return alertViewController
    }

    private func distinguishCardType(of model: CardModel?) -> (CardType, CardType) {
        switch model?.cardType {
        case .todo:
            return (.doing, .done)
        case .doing:
            return (.todo, .done)
        default:
            return (.todo, .doing)
        }
    }
}
