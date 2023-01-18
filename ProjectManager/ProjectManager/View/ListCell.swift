//
//  ListCellTableViewCell.swift
//  ProjectManager
//
//  Created by leewonseok on 2023/01/11.
//

import UIKit

protocol CellDelegate: AnyObject {
    func showPopover(cell: ListCell)
}

final class ListCell: UITableViewCell {
    static let identifier = ListCell.description()

    var viewModel = ListCellViewModel()
    
    weak var delegate: CellDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title2)
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
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
            self?.titleLabel.text = work?.title
            self?.bodyLabel.text = work?.body
            self?.dateLabel.text = work?.endDateToString
        }
    }
    
    func configureData(work: Work) {
        viewModel.work = work
    }
    
    private func configureLayout() {
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
}

extension ListCell {
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
            delegate?.showPopover(cell: self)
        }
    }
}
