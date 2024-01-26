//
//  WorkView.swift
//  ProjectManager
//
//  Created by BMO on 2023/10/02.
//

import UIKit

final class WorkView: UIView {
    private let workStatus: Work.Status
    private let workViewModel = WorkViewModel()
    private var works: [Work] = []
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private let titleSatckView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.backgroundColor = .systemBackground
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .white
        label.backgroundColor = .black
        label.textAlignment = .center
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return label
    }()
    
    private let titleSpacer = UIView()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(WorkCell.self, forCellReuseIdentifier: WorkCell.identifier)
        tableView.backgroundColor = .systemGray6
        
        return tableView
    }()
    
    init(workStatus: Work.Status) {
        self.workStatus = workStatus
        
        super.init(frame: .init())
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setUI()
        setBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        titleLabel.text = workStatus.rawValue
        
        addSubview(stackView)
        stackView.addArrangedSubview(titleSatckView)
        stackView.addArrangedSubview(createDivider())
        stackView.addArrangedSubview(tableView)
        titleSatckView.addArrangedSubview(titleLabel)
        titleSatckView.addArrangedSubview(countLabel)
        titleSatckView.addArrangedSubview(titleSpacer)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func createDivider() -> UIView {
        let divider: UIView = {
            let view = UIView()
            view.backgroundColor = .systemGray4
            view.translatesAutoresizingMaskIntoConstraints = false
            view.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
            
            return view
        }()
        
        return divider
    }
    
    private func setBindings() {
        workViewModel.works.bind { [weak self] works in
            guard let works else { return }
            self?.works = works
            self?.countLabel.text = works.count.description
        }
    }
}

extension WorkView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return works.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WorkCell.identifier, for: indexPath) as? WorkCell else {
            return UITableViewCell()
        }
        
        let work = works[indexPath.row]
        
        cell.config(title: work.title, description: work.description, deadline: work.deadline)
        
        return cell
    }
}

extension WorkView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, complition in
            // TODO: 테이블뷰 셀 제거 로직 작성
            print("delete tableView row")

            guard let self else { return }
            self.works.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            workViewModel.updateWorks(self.works)

            complition(true)
        }

        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])

        return configuration
    }
}
