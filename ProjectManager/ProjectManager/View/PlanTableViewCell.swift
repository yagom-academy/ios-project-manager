//
//  PlanTableViewCell.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/17.
//

import UIKit
import Combine

final class PlanTableViewCell: UITableViewCell {
    private var planTableCellViewModel: PlanTableCellViewModel?
    private var cancellables: Set<AnyCancellable> = []

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .fill
        
        return stackView
    }()
    
    private let title: UILabel = {
        let title = UILabel()
        title.textColor = .black
        title.font = UIFont.preferredFont(forTextStyle: .title1)
        title.numberOfLines = 1
        
        return title
    }()
    
    private let body: UILabel = {
        let title = UILabel()
        title.textColor = .secondaryLabel
        title.font = UIFont.preferredFont(forTextStyle: .body)
        title.numberOfLines = 3
        
        return title
    }()
    
    private let date: UILabel = {
        let title = UILabel()
        
        return title
    }()

    override func prepareForReuse() {
        super.prepareForReuse()
        cancellables.removeAll()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpStackView() {
        self.addSubview(stackView)
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(body)
        stackView.addArrangedSubview(date)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
    private func setUpBinding() {
        planTableCellViewModel?.$plan
            .map { plan in
                plan.title
            }.sink {
                self.title.text = $0
            }.store(in: &cancellables)
        
        planTableCellViewModel?.$plan
            .map { plan in
                plan.body
            }.sink {
                self.body.text = $0
            }.store(in: &cancellables)
        
        planTableCellViewModel?.$plan
            .map { plan in
                plan.date
            }
            .sink {
                self.date.textColor = self.planTableCellViewModel?.selectColor($0).color
                self.date.text = self.planTableCellViewModel?.convertDate(of: $0)
            }.store(in: &cancellables)
    }
    
    func configureCell(with plan: Plan) {
        self.planTableCellViewModel = PlanTableCellViewModel(plan: plan)
        setUpBinding()
    }
    
    func fetchCellPlan() -> Plan? {
        return planTableCellViewModel?.fetchPlan()
    }
}
