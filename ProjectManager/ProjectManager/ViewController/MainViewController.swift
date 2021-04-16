//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var todoCardsTableView: UITableView!
    @IBOutlet weak var doingCardsTableView: UITableView!
    @IBOutlet weak var doneCardsTableView: UITableView!
    
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
        
        cardViewController.delegate = self
        
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
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let cardStatus: Card.Status
        switch tableView {
        case todoCardsTableView:
            cardStatus = .todo
        case doingCardsTableView:
            cardStatus = .doing
        case doneCardsTableView:
            cardStatus = .done
        default:
            cardStatus = .todo
        }
        
        dataManager.deleteCard(status: cardStatus, index: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        
        let statusText: String
        switch tableView {
        case todoCardsTableView:
            let cardCount = dataManager.cardCount(status: .todo)
            statusText = "TODO (\(cardCount))"
        case doingCardsTableView:
            let cardCount = dataManager.cardCount(status: .doing)
            statusText = "DOING (\(cardCount))"
        case doneCardsTableView:
            let cardCount = dataManager.cardCount(status: .done)
            statusText = "DONE (\(cardCount))"
        default:
            statusText = "TODO"
            break
        }
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: tableView.sectionHeaderHeight))
        let label = UILabel(frame: CGRect(x: 10, y: 5, width: tableView.frame.size.width, height: tableView.sectionHeaderHeight))
        label.font = UIFont.systemFont(ofSize: 22)
        label.text = statusText
        view.addSubview(label)
        view.backgroundColor = .systemGray6
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard section == 0 else { return 0 }
        
        return 40
    }
}

extension MainViewController: UITableViewDataSource {
    
    func setupTableView() {
        let nib = UINib(nibName: "CardsTableViewCell", bundle: nil)
        
        todoCardsTableView.delegate = self
        todoCardsTableView.dataSource = self
        todoCardsTableView.register(nib, forCellReuseIdentifier: CardsTableViewCell.identifier)
        todoCardsTableView.tag = Card.Status.todo.tag
        todoCardsTableView.tableFooterView = UIView(frame: CGRect.zero)
        todoCardsTableView.backgroundColor = .systemGray6
        
        doingCardsTableView.delegate = self
        doingCardsTableView.dataSource = self
        doingCardsTableView.register(nib, forCellReuseIdentifier: CardsTableViewCell.identifier)
        doingCardsTableView.tag = Card.Status.doing.tag
        doingCardsTableView.tableFooterView = UIView(frame: CGRect.zero)
        doingCardsTableView.backgroundColor = .systemGray6

        doneCardsTableView.delegate = self
        doneCardsTableView.dataSource = self
        doneCardsTableView.register(nib, forCellReuseIdentifier: CardsTableViewCell.identifier)
        doneCardsTableView.tag = Card.Status.done.tag
        doneCardsTableView.tableFooterView = UIView(frame: CGRect.zero)
        doneCardsTableView.backgroundColor = .systemGray6
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }
        
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

extension MainViewController: CardViewControllerDelegate {
    func cardViewController(_ cardViewController: CardViewController, didUpdateCard: Card) {
        guard let index = dataManager.cardIndex(card: didUpdateCard) else { return }
        
        switch didUpdateCard.status {
        case .todo:
            todoCardsTableView.reloadRows(at: [IndexPath(row: index, section: 1)], with: .automatic)
        case .doing:
            doingCardsTableView.reloadRows(at: [IndexPath(row: index, section: 1)], with: .automatic)
        case .done:
            doneCardsTableView.reloadRows(at: [IndexPath(row: index, section: 1)], with: .automatic)
        }
    }
    
    func cardViewController(_ cardViewController: CardViewController, addNewCard: Card) {
        switch addNewCard.status {
        case .todo:
            let insertRow = todoCardsTableView.numberOfRows(inSection: 1)
            todoCardsTableView.insertRows(at: [IndexPath(row: insertRow, section: 1)], with: .automatic)
        case .doing:
            let insertRow = doingCardsTableView.numberOfRows(inSection: 1)
            doingCardsTableView.insertRows(at: [IndexPath(row: insertRow, section: 1)], with: .automatic)
        case .done:
            let insertRow = doneCardsTableView.numberOfRows(inSection: 1)
            doneCardsTableView.insertRows(at: [IndexPath(row: insertRow, section: 1)], with: .automatic)
        }
        todoCardsTableView.reloadSections(IndexSet(arrayLiteral: 0), with: .none)
    }
}
