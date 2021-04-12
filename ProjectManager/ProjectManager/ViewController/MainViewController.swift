//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var todoCardsTableView: CardsTableView!
    @IBOutlet weak var doingCardsTableView: CardsTableView!
    @IBOutlet weak var doneCardsTableView: CardsTableView!
    
    private let presentCardSegueIdentifier: String = "presentCard"
    private lazy var dataManager: DataManager = {
        return DataManager.shared
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cardViewController = segue.destination as? CardViewController else {
            return
        }
        
        if let card = sender as? Card {
            cardViewController.mode = .presentCard
            cardViewController.card = card
        } else {
            cardViewController.mode = .addCard
        }
    }
    
    @IBAction func touchUpAddButton(_ sender: Any) {
        performSegue(withIdentifier: presentCardSegueIdentifier, sender: nil)
    }
    
    
    private func loadData() {
        dataManager.loadData()
        todoCardsTableView.reloadData()
        doingCardsTableView.reloadData()
        doneCardsTableView.reloadData()
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let status = Card.Status(rawValue: tableView.tag) {
            let card = dataManager.card(status: status, index: indexPath.row)
            performSegue(withIdentifier: presentCardSegueIdentifier, sender: card)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MainViewController: UITableViewDataSource {
    
    func setupTableView() {
        let nib = UINib(nibName: "CardsTableViewCell", bundle: nil)
        
        todoCardsTableView.delegate = self
        todoCardsTableView.dataSource = self
        todoCardsTableView.register(nib, forCellReuseIdentifier: CardsTableViewCell.identifier)
        todoCardsTableView.tag = Card.Status.todo.tag
        
        doingCardsTableView.delegate = self
        doingCardsTableView.dataSource = self
        doingCardsTableView.register(nib, forCellReuseIdentifier: CardsTableViewCell.identifier)
        doingCardsTableView.tag = Card.Status.doing.tag

        doneCardsTableView.delegate = self
        doneCardsTableView.dataSource = self
        doneCardsTableView.register(nib, forCellReuseIdentifier: CardsTableViewCell.identifier)
        doneCardsTableView.tag = Card.Status.done.tag
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let status = Card.Status(rawValue: tableView.tag) {
            return dataManager.cardCount(status: status)
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: CardsTableViewCell = tableView.dequeueReusableCell(withIdentifier: CardsTableViewCell.identifier, for: indexPath) as? CardsTableViewCell,
              let status = Card.Status(rawValue: tableView.tag) else {
            return CardsTableViewCell()
        }
    
        let card = dataManager.card(status: status, index: indexPath.row)
        cell.configure(card: card)
        
        return cell
    }
}
