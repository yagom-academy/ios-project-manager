//
//  DataManager.swift
//  ProjectManager
//
//  Created by Kyungmin Lee on 2021/04/11.
//

import UIKit

class DataManager {
    static let shared = DataManager()
    
    private var cardList: CardList?
    private var cards: [[Card]] = Array(repeating: [], count: Card.Status.allCases.count)
    
    private init() {}
    
    func loadData() {
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "itemsMock") else { return }
        
        do {
            cardList = try JSONDecoder().decode(CardList.self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
        
        guard let cards = cardList?.cards else { return }
        
        for status in Card.Status.allCases {
            self.cards[status.index] = cards.filter {$0.status == status}
        }
    }
    
    func card(status: Card.Status, index: Int) -> Card {
        return cards[status.index][index]
    }
    
    func cardCount(status: Card.Status) -> Int {
        return cards[status.index].count
    }
}
