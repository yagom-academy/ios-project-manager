//
//  NetworkManager.swift
//  ProjectManager
//
//  Created by 리나 on 2021/03/19.
//

import Foundation
import Alamofire

struct NetworkManager {
    static func fetch(_ completionHandler: @escaping (Result<[Things], Error>) -> Void) {
        AF.request(Strings.baseURL).validate(statusCode: 200..<300).responseDecodable(of: [Things].self) { response in
            switch response.result {
            case .success(let things):
                completionHandler(.success(things))
            case .failure(let error):
                completionHandler(.failure(error))
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    static func create(thing: Thing, _ completionHandler: @escaping (Result<NSDictionary?, Error>) -> Void) {
        AF.request(Strings.baseURL, method: .post, parameters: thing.parameters).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {
            case .success(let data):
                if let data = data as? NSDictionary, let id = data.value(forKey: "id") as? Int32 {
                    thing.id = id
                    completionHandler(.success(data))
                }
            case .failure(let error):
                completionHandler(.failure(error))
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    static func delete(id: Int, _ completionHandler: @escaping (Result<Codable?, Error>) -> Void)  {
        let absoluteURL = String(format: Strings.absoluteURL, id)
        AF.request(absoluteURL, method: .delete).validate(statusCode: 200..<300).response { response in
            switch response.result {
            case .success(let data):
                if let data = data {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        dump(json)
                    }
                } else {
                    completionHandler(.success(nil))
                }
            case .failure(let error):
                completionHandler(.failure(error))
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    static func update(thing: Thing, _ completionHandler: @escaping (Result<Codable?, Error>) -> Void) {
        let id = thing.id
        let absoluteURL = String(format: Strings.absoluteURL, id)
        AF.request(absoluteURL, method: .patch, parameters: thing.parameters).validate(statusCode: 200..<300).response { response in
            switch response.result {
            case .success(let data):
                if let data = data {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        dump(json)
                    }
                } else {
                    completionHandler(.success(nil))
                }
            case .failure(let error):
                completionHandler(.failure(error))
                debugPrint(error.localizedDescription)
            }
        }
    }
}
