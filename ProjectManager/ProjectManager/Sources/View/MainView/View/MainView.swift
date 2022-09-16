//
//  MainView.swift
//  ProjectManager
//
//  Created by 유한석 on 2022/09/12.
//

import UIKit

final class MainView: UIView {
    
    //MARK: - UI Properties
    
    let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    let todoListView = ListView(frame: .zero)
    let doingListView = ListView(frame: .zero)
    let doneListView = ListView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addUIComponents()
        setupListViewLayout()
        setupListViewTitleLabel()
        
        todoListView.translatesAutoresizingMaskIntoConstraints = false
        doingListView.translatesAutoresizingMaskIntoConstraints = false
        doneListView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

private extension MainView {
    
    //MARK: - Setup List View Initial State
    
    func addUIComponents() {
        self.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(todoListView)
        mainStackView.addArrangedSubview(doingListView)
        mainStackView.addArrangedSubview(doneListView)
    }
    
    func setupListViewLayout() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupListViewTitleLabel() {
        todoListView.mainTitleLabel.text = ProjectTaskState.TODO.rawValue
        doingListView.mainTitleLabel.text = ProjectTaskState.DOING.rawValue
        doneListView.mainTitleLabel.text = ProjectTaskState.DONE.rawValue
    }
}
