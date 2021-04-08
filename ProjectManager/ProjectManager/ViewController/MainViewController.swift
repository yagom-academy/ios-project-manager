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
    
    private var cardList: CardList?
    private var todoCards: [Card] = []
    private var doingCards: [Card] = []
    private var doneCards: [Card] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        loadData()
    }
    
    private func loadData() {
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "itemsMock") else { return }
        
        do {
            cardList = try JSONDecoder().decode(CardList.self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
        
        guard let cards = cardList?.cards else { return }
        
        todoCards = cards.filter {$0.status == 0}
        doingCards = cards.filter {$0.status == 1}
        doneCards = cards.filter {$0.status == 2}
                
        todoCardsTableView.reloadData()
        doingCardsTableView.reloadData()
        doneCardsTableView.reloadData()
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        let nib = UINib(nibName: "CardsTableViewCell", bundle: nil)
        
        todoCardsTableView.delegate = self
        todoCardsTableView.dataSource = self
        todoCardsTableView.register(nib, forCellReuseIdentifier: CardsTableViewCell.identifier)
        todoCardsTableView.tag = 0
        
        doingCardsTableView.delegate = self
        doingCardsTableView.dataSource = self
        doingCardsTableView.register(nib, forCellReuseIdentifier: CardsTableViewCell.identifier)
        doingCardsTableView.tag = 1

        doneCardsTableView.delegate = self
        doneCardsTableView.dataSource = self
        doneCardsTableView.register(nib, forCellReuseIdentifier: CardsTableViewCell.identifier)
        doneCardsTableView.tag = 2

        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView.tag {
        case 0:
            return todoCards.count
        case 1:
            return doingCards.count
        case 2:
            return doneCards.count
        default:
            break
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: CardsTableViewCell = tableView.dequeueReusableCell(withIdentifier: CardsTableViewCell.identifier, for: indexPath) as? CardsTableViewCell else {
            return CardsTableViewCell()
        }
 
        let cards: [Card]
        
        switch tableView.tag {
        case 0:
            cards = todoCards
        case 1:
            cards = doingCards
        case 2:
            cards = doneCards
        default:
            cards = todoCards
        }
        
        cell.titleLabel?.text = cards[indexPath.row].title
        cell.descriptionsLabel?.text = cards[indexPath.row].descriptions
        cell.deadlineLabel?.text = "\(cards[indexPath.row].deadline)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
    
}
