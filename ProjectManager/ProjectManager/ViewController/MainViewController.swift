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
    
    private let showCardDetailSegueIdentifier: String = "showCardDetail"
    private var cardList: CardList?
    private var todoCards: [Card] = []
    private var doingCards: [Card] = []
    private var doneCards: [Card] = []
    

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
            cardViewController.card = card
        } else {
            
        }
    }
    
    @IBAction func touchUpAddButton(_ sender: Any) {
        performSegue(withIdentifier: showCardDetailSegueIdentifier, sender: nil)
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

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cards: [Card]
        
        switch tableView.tag {
            case Constants.CardStatus.todo:
                cards = todoCards
            case Constants.CardStatus.doing:
                cards = doingCards
            case Constants.CardStatus.done:
                cards = doneCards
            default:
                cards = todoCards
        }
        
        performSegue(withIdentifier: showCardDetailSegueIdentifier, sender: cards[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MainViewController: UITableViewDataSource {
    
    func setupTableView() {
        let nib = UINib(nibName: "CardsTableViewCell", bundle: nil)
        
        todoCardsTableView.delegate = self
        todoCardsTableView.dataSource = self
        todoCardsTableView.register(nib, forCellReuseIdentifier: CardsTableViewCell.identifier)
        todoCardsTableView.tag = Constants.CardStatus.todo
        
        doingCardsTableView.delegate = self
        doingCardsTableView.dataSource = self
        doingCardsTableView.register(nib, forCellReuseIdentifier: CardsTableViewCell.identifier)
        doingCardsTableView.tag = Constants.CardStatus.doing

        doneCardsTableView.delegate = self
        doneCardsTableView.dataSource = self
        doneCardsTableView.register(nib, forCellReuseIdentifier: CardsTableViewCell.identifier)
        doneCardsTableView.tag = Constants.CardStatus.done

        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView.tag {
        case Constants.CardStatus.todo:
            return todoCards.count
        case Constants.CardStatus.doing:
            return doingCards.count
        case Constants.CardStatus.done:
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
        case Constants.CardStatus.todo:
            cards = todoCards
        case Constants.CardStatus.doing:
            cards = doingCards
        case Constants.CardStatus.done:
            cards = doneCards
        default:
            cards = todoCards
        }
        
        cell.configure(card: cards[indexPath.row])
        
        return cell
    }
}
