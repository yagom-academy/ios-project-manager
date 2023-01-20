//
//  ListCellTableViewCell.swift
//  ProjectManager
//
//  Created by leewonseok on 2023/01/11.
//

import UIKit

protocol CellDelegate: AnyObject {
    func showPopover(soruceView: UIView?, work: Work?)
}

final class ListCell: UITableViewCell {
    static let identifier = ListCell.description()

    var viewModel = ListCellViewModel()
    
    weak var delegate: CellDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .preferredFont(forTextStyle: .title2)
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 3
        label.textColor = .gray
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        confgiureGesture()
        configureBind()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureBind() {
        viewModel.bind { [weak self] work in
            self?.titleLabel.text = work.title
            self?.bodyLabel.text = work.body
            self?.dateLabel.text = work.endDateToString
            self?.dateLabel.textColor = work.endDate < Date() ? .red : .black
        }
    }
    
    func configureData(work: Work) {
        viewModel.work = work
    }
    
    private func configureLayout() {
        separatorInset = .zero
        
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(bodyLabel)
        stackView.addArrangedSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func confgiureGesture() {
         let longPressedGesture = UILongPressGestureRecognizer(target: self,
                                                               action: #selector(handleLongPress(gestureRecognizer:)))
         longPressedGesture.minimumPressDuration = 0.2
         longPressedGesture.delegate = self
         longPressedGesture.delaysTouchesBegan = true
         self.addGestureRecognizer(longPressedGesture)
     }
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            delegate?.showPopover(soruceView: self, work: viewModel.work)
        }
    }
}
