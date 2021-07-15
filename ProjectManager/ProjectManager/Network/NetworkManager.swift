//
//  NetworkManager.swift
//  ProjectManager
//
//  Created by 강경 on 2021/07/15.
//

import Foundation



class NetworkManager {
    func responseData(
        type: TableViewType,
        page: Int,
        complete: @escaping ((ReceivedMemoModel) -> Void)
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
    
    func postData(
        type: TableViewType,
        data: Memo,
        complete: @escaping (() -> Void)
    ) {
        guard let requestURL = RequestType.postProduct.url
        else {
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HttpMethod.post.rawValue
        request.setValue(
            Strings.jsonTypeOfRequestValue,
            forHTTPHeaderField: Strings.contentTypeOfHTTPHeaderField
        )
        
        let postMemoModel = PostMemoModel(
            title: data.title,
            content: data.content,
            dueDate: data.dueDate,
            memoType: data.memoType
        )
        
        guard let encodedData = try? JSONEncoder().encode(postMemoModel)
        else {
            return
        }
        request.httpBody = encodedData
        
        let urlSession = URLSession.shared
        urlSession.dataTask(with: request) { (data, response, error) in
            guard let responseStatus = response as? HTTPURLResponse,
                  responseStatus.statusCode == 200
            else {
                guard let data = data,
                      error == nil
                else {
                    print(NetworkError.invalidData)
                    return
                }
                
                do {
                    let urlResponse = try JSONDecoder().decode(
                        RequestError.self,
                        from: data
                    )
                    print("error: \(urlResponse.reason)")
                } catch {
                    print(NetworkError.DecodingProblem)
                }
                print(NetworkError.invalidResponse)
                return
            }
        }.resume()
    }
    
    func patchData(
        type: TableViewType,
        data: Memo,
        id: String,
        complete: @escaping (() -> Void)
    ) {
        guard let requestURL = RequestType.patchProduct(id: id).url
        else {
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HttpMethod.patch.rawValue
        request.setValue(
            Strings.jsonTypeOfRequestValue,
            forHTTPHeaderField: Strings.contentTypeOfHTTPHeaderField
        )
        
        let postMemoModel = PostMemoModel(
            title: data.title,
            content: data.content,
            dueDate: data.dueDate,
            memoType: data.memoType
        )
        
        guard let encodedData = try? JSONEncoder().encode(postMemoModel)
        else {
            return
        }
        request.httpBody = encodedData
        
        let urlSession = URLSession.shared
        urlSession.dataTask(with: request) { (data, response, error) in
            guard let responseStatus = response as? HTTPURLResponse,
                  responseStatus.statusCode == 200
            else {
                guard let data = data,
                      error == nil
                else {
                    print(NetworkError.invalidData)
                    return
                }
                
                do {
                    let urlResponse = try JSONDecoder().decode(
                        RequestError.self,
                        from: data
                    )
                    print("error: \(urlResponse.reason)")
                } catch {
                    print(NetworkError.DecodingProblem)
                }
                print(NetworkError.invalidResponse)
                return
            }
        }.resume()
    }
}
