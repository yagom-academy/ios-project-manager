//
//  NetworkManager.swift
//  ProjectManager
//
//  Created by 강경 on 2021/07/15.
//

import Foundation

final class NetworkManager {
    // TODO: - 반복되는 부분(urlSession.dataTask)을 재사용할 수 있는 방법에 대해 고민해보자
    func getData(
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
                print(NetworkError.decodingProblem)
            }
        }.resume()
    }
    
    func postData(
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
                    print(NetworkError.decodingProblem)
                }
                print(NetworkError.invalidResponse)
                return
            }
            
            complete()
        }.resume()
    }
    
    func patchData(
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
                    print(NetworkError.decodingProblem)
                }
                print(NetworkError.invalidResponse)
                return
            }
            
            complete()
        }.resume()
    }
    
    func deleteData(
        id: String,
        complete: @escaping (() -> Void)
    ) {
        guard let requestURL = RequestType.deleteProduct(id: id).url
        else {
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HttpMethod.delete.rawValue
        request.setValue(
            Strings.jsonTypeOfRequestValue,
            forHTTPHeaderField: Strings.contentTypeOfHTTPHeaderField
        )
        
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
                    print(NetworkError.decodingProblem)
                }
                print(NetworkError.invalidResponse)
                return
            }
            
            complete()
        }.resume()
    }
}
