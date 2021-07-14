//
//  NetworkManager.swift
//  ProjectManager
//
//  Created by 강경 on 2021/07/15.
//

import Foundation



class NetworkManager {
    func search(
        type: TableViewType,
        page: Int,
        complete: @escaping ((ReceivedMemoModel?) -> Void)
    ) {
        guard let requestURL = RequestType.loadPage(type, page).url
        else {
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HttpMethod.get.rawValue
        
        let urlSession = URLSession.shared
        urlSession.dataTask(with: request) { (data, response, error) in
            guard let responseStatus = response as? HTTPURLResponse,
                  responseStatus.statusCode == 200
            else {
                print(NetworkError.invalidResponse)
                return
            }
            
            guard let data = data,
                  error == nil
            else {
                print(NetworkError.invalidData)
                return
            }
            
            do {
                let urlResponse = try JSONDecoder().decode(
                    ReceivedMemoModel.self,
                    from: data
                )
                complete(urlResponse)
            } catch {
                print(NetworkError.DecodingProblem)
            }
        }.resume()
    }
}
