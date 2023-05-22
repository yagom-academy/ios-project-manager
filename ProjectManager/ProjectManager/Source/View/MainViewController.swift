//
//  ProjectManager - MainViewController.swift
//  Created by songjun, vetto. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    
    let schedule = Schedule(title: "asd", detail: "asd", expirationDate: Date())
    let schedule2 = Schedule(title: "sdf", detail: "sdf", expirationDate: Date())
    let schedule3 = Schedule(title: "sdf", detail: "sdf", expirationDate: Date())
    
    var schedules: [Schedule] = []
    func createSchedules() {
        for i in 0..<10 {
            schedules.append(Schedule(title: "\(i)", detail: "hi", expirationDate: Date()))
        }
    }
    lazy var schedules2 = [schedule2]
    lazy var schedules3 = [schedule3]
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.backgroundColor = .lightGray
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let todoView = TodoView()
    private let doingView = DoingView()
    private let doneView = DoneView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        createSchedules()
        configureUI()
        todoView.configureUI()
        todoView.configureDataSource(schedule: schedule)
        todoView.applySnapshot(schedules: schedules)
        doingView.configureUI()
        doingView.configureDataSource(schedule: schedule2)
        doingView.applySnapshot(schedules: schedules2)
        doneView.configureUI()
        doneView.configureDataSource(schedule: schedule3)
        doneView.applySnapshot(schedules: schedules3)
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        let buttonItem: UIBarButtonItem = {
            let button = UIBarButtonItem(barButtonSystemItem: .add,
                                         target: self,
                                         action: #selector(tabPlusButton))
            
            return button
        }()
        
        navigationItem.rightBarButtonItem = buttonItem
        self.title = "ProjectManager"
    }
    
    @objc func tabPlusButton() {
        presentEditModal()
    }
    
    private func presentEditModal() {
        let modalViewController = ModalViewController()
        let modalNavigationController = UINavigationController(rootViewController: modalViewController)
        modalViewController.modalPresentationStyle = .formSheet
        modalViewController.preferredContentSize = CGSize(width: view.bounds.width * 0.5, height: view.bounds.height * 0.7)
        
        present(modalNavigationController, animated: true, completion: nil)
    }
    
    private func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        view.addSubview(stackView)
        stackView.addArrangedSubview(todoView)
        stackView.addArrangedSubview(doingView)
        stackView.addArrangedSubview(doneView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}
