//
//  ThingTableView.swift
//  ProjectManager
//
//  Created by 임성민 on 2021/03/17.
//

import UIKit
import Alamofire

class ThingTableView: UITableView, Draggable, Droppable {
    
    //MARK: - Property
    
    var state: Thing.State? = nil
    var list: [Thing] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
    
    //MARK: - Init
    
    init(state: Thing.State) {
        super.init(frame: .zero, style: .grouped)
        self.state = state
        tableHeaderView = ThingTableHeaderView(height: 50, title: state.rawValue)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - CRUD
    // TODO: 업데이트, 삭제 하기전에, id값 받아와야함... 실패,성공 경우마다 UI에 반영해줘야함
    func createThing(_ thing: Thing) {
        AF.request(Strings.baseURL, method: .post, parameters: thing.parameters).response { response in
            switch response.result {
            case .success(let data):
                debugPrint("생성: \(String(describing: data))")
            case .failure(let error):
                debugPrint("error: \(error.localizedDescription)")
            }
            self.list.append(thing)
        }
    }
    
    func updateThing(_ thing: Thing, index: Int) {
        guard let id = thing.id else {
            return
        }
        let idString = String(id)
        dump(thing)
        print("\(id), \(idString)")
        AF.request("\(Strings.baseURL)/\(idString)", method: .patch, parameters: thing.parameters).response { response in
            switch response.result {
            case .success(let data):
                debugPrint("생성: \(String(describing: data))")
//                if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
//                    dump(json)
//                }
            case .failure(let error):
                debugPrint("error: \(error)")
            }
            self.list[index] = thing
        }
    }
    
    func deleteThing(at indexPath: IndexPath, id: Int?) {
        guard let id = id else {
            return
        }
        let idString = String(id)
        AF.request("\(Strings.baseURL)/\(idString)", method: .delete).response { response in
            switch response.result {
            case .success(let data):
                debugPrint("삭제: \(String(describing: data))")
            case .failure(let error):
                debugPrint("error: \(error.localizedDescription)")
            }
            self.list.remove(at: indexPath.row)
        }
        
    }
    
    func removeThing(at indexPath: IndexPath) {
        list.remove(at: indexPath.row)
    }
    
    func insertThing(_ thing: Thing, at indexPath: IndexPath) {
        guard let id = thing.id else {
            return
        }
        let idString = String(id)
        AF.request("\(Strings.baseURL)/\(idString)", method: .patch, parameters: thing.parameters).response { response in
            switch response.result {
            case .success(let data):
                debugPrint("이동: \(String(describing: data))")
            case .failure(let error):
                debugPrint("error: \(error)")
            }
            self.list.insert(thing, at: indexPath.row)
        }
    }
    
    //MARK: - Network
    
    func fetchList(_ list: [Thing]) {
        self.list = list
    }
    
    //MARK: - set Count
    
    func setCount(_ count: Int) {
        if let tableHeaderView = self.tableHeaderView as? ThingTableHeaderView {
            tableHeaderView.setCount(count)
        }
    }
    
}
