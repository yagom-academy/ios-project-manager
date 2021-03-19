//
//  NetworkManager.swift
//  ProjectManager
//
//  Created by 리나 on 2021/03/19.
//

import Alamofire

struct NetworkManager {
    static func fetch(_ completionHandler: @escaping (Result<[Things], Error>) -> Void) {
        AF.request(Strings.baseURL).responseDecodable(of: [Things].self) { response in
            switch response.result {
            case .success(let things):
                completionHandler(.success(things))
            case .failure(let error):
                completionHandler(.failure(error))
                debugPrint(error.localizedDescription)
            }
        }
    }
}
