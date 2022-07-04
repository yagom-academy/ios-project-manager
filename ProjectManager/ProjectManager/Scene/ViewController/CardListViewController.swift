//
//  CardListViewController.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/04.
//

import UIKit
import RxSwift
import RxCocoa

final class CardListViewController: UIViewController {
  private let todoTableView = UITableView()
  private let doingTableView = UITableView()
  private let doneTableView = UITableView()

  private let viewModel = CardListViewModel()
  
  init() {
    super.init(nibName: nil, bundle: nil)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  private func configureUI() {
    view.backgroundColor = .systemGray4
    let tableViews = [todoTableView, doingTableView, doneTableView]
    tableViews.forEach { $0.backgroundColor = .systemGray5 }
    
    let containerStackView = UIStackView(arrangedSubviews: tableViews)
    containerStackView.axis = .horizontal
    containerStackView.spacing = 20.0
    containerStackView.distribution = .fillEqually
    containerStackView.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(containerStackView)
    NSLayoutConstraint.activate([
      containerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      containerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      containerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      containerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
    ])
  }
}
