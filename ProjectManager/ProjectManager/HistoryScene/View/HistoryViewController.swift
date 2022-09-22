//
//  HistoryView.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/19.
//

import UIKit

final class HistoryViewController: UIViewController {
    
    // MARK: - UIComponents
    private let verticalStackView = DefaultStackViewBuilder()
        .useAutoLayout()
        .setAxis(.vertical)
        .setAlignment(.fill)
        .useLayoutMargin()
        .setLayoutMargin(top: 10,
                         left: 10,
                         bottom: 10,
                         right: 10)
        .stackView
    
    private let emptyHistoryLabel = DefaultLabelBuilder()
        .useAutoLayout()
        .setText(with: "기록이 없습니다.")
        .setPreferredFont(.body)
        .setTextAlignment(.center)
        .label
    
    let viewModel: HistoryViewModel
    
    // MARK: - Initializer
    init(viewModel: HistoryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupDynamicHeight()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVerticalStackView()
        setupCell()
    }
    
    // MARK: - Methods
    private func setupDynamicHeight() {
        if viewModel.histories.count == 0 {
            preferredContentSize = CGSize(
                width: 200,
                height: 40
            )
            verticalStackView.addArrangedSubview(emptyHistoryLabel)
        } else {
            preferredContentSize = CGSize(
                width: 600,
                height: 80 * (viewModel.histories.count) + 20
            )
        }
    }
    
    private func setupVerticalStackView() {
        view.addSubview(verticalStackView)
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(
                equalTo: view.topAnchor
            ),
            verticalStackView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            ),
            verticalStackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            verticalStackView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor
            )
        ])
    }
    
    private func setupCell() {
        viewModel.histories.forEach {
            addCell(model: $0)
        }
    }
    
    private func addCell(model: History) {
        let cell = HistoryCell(frame: .zero)
        cell.setupData(title: model.title, date: model.date)
        verticalStackView.addArrangedSubview(cell)
    }
}
