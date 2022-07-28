//
//  HistoryViewController.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/26.
//

import UIKit

final class HistoryViewController: UIViewController {
  private let historyTableViewView: UITableView = {
    let scrollView = UITableView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.indicatorStyle = .black
    scrollView.backgroundColor = .systemBlue
    return scrollView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  private func configureUI() {
    view.addSubview(historyTableViewView)
    
    NSLayoutConstraint.activate([
      historyTableViewView.topAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.topAnchor,
        constant: 20
      ),
      historyTableViewView.bottomAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.bottomAnchor,
        constant: -20
      ),
      historyTableViewView.leadingAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.leadingAnchor,
        constant: 10
      ),
      historyTableViewView.trailingAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.trailingAnchor,
        constant: -10
      )
    ])
  }
}
