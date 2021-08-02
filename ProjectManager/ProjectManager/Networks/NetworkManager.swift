//
//  NetworkManager.swift
//  ProjectManager
//
//  Created by 최정민 on 2021/07/19.
//

import Foundation

struct NetworkManager {
    private let baseURL = "https://vaporpms.herokuapp.comd"
    private let indicatorView = IndicatorView()
    
    private func checkValidation(data: Data?, response: URLResponse?, error: Error?) -> Bool {
        if let error = error {
            self.indicatorView.dismiss()
            ProjectManagerViewController.networkStatus = .disconnection
            setUpNotificationCenterPost()
            print("\nError: \(error)\n")
            return false
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Invalid Response")
            self.indicatorView.dismiss()
            ProjectManagerViewController.networkStatus = .disconnection
            setUpNotificationCenterPost()
            return false
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            print("Status Code: \(httpResponse.statusCode)")
            self.indicatorView.dismiss()
            ProjectManagerViewController.networkStatus = .disconnection
            setUpNotificationCenterPost()
            return false
        }
        
        guard let _ = data else {
            print("Invalid Data")
            self.indicatorView.dismiss()
            ProjectManagerViewController.networkStatus = .disconnection
            setUpNotificationCenterPost()
            return false
        }
        ProjectManagerViewController.networkStatus = .connection
        setUpNotificationCenterPost()
        return true
    }
    
    private func setUpNotificationCenterPost() {
        let networkStatusNotification = NSNotification.Name.init("network Status")
        NotificationCenter.default.post(name: networkStatusNotification, object: nil)
    }
    
    private func encodedData<T>(data: T) -> Data? where T: Encodable{
        let encoder = JSONEncoder()
        return try? encoder.encode(data)
    }
    
    func get(completion: @escaping ([Task]?) -> ()) {
        let urlString = baseURL + "/tasks"
        guard let url = URL(string: urlString) else {
            return
        }
        self.indicatorView.showIndicator()
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard self.checkValidation(data: data, response: response, error: error) else {
                completion(nil)
                return
            }
            guard let data = data else { return }
            guard let tasks = try? JSONDecoder().decode([Task].self, from: data) else { return }
            self.indicatorView.dismiss()
            completion(tasks)
        }.resume()
    }
    
    func post(task: Task, completion: @escaping (Task?) -> ()) {
        let urlString = baseURL + "/tasks"
        guard let url = URL(string: urlString) else {
            return
        }
        
        var requset = URLRequest(url: url)
        
        requset.addValue("application/json", forHTTPHeaderField: "Content-Type")
        requset.httpMethod = "POST"
        requset.httpBody = encodedData(data: task)
        
        URLSession.shared.dataTask(with: requset) { data, response, error in
            guard self.checkValidation(data: data, response: response, error: error) else {
                completion(nil)
                return
            }
            guard let data = data else { return }
            guard let task = try? JSONDecoder().decode(Task.self, from: data) else { return }
            completion(task)
        }.resume()
    }
    
    func patch(task: Task, completion: @escaping (Task?) -> ()) {
        let urlString = baseURL + "/tasks" + "/\(task.id)"
        guard let url = URL(string: urlString) else {
            return
        }
        
        var requset = URLRequest(url: url)
        
        requset.addValue("application/json", forHTTPHeaderField: "Content-Type")
        requset.httpMethod = "PATCH"
        requset.httpBody = encodedData(data: task)
        
        URLSession.shared.dataTask(with: requset) { data, response, error in
            guard self.checkValidation(data: data, response: response, error: error) else {
                completion(nil)
                return
            }
            guard let data = data else { return }
            guard let task = try? JSONDecoder().decode(Task.self, from: data) else { return }
            completion(task)
        }.resume()
    }
    
    func delete(id: String, completion: @escaping (Bool) -> ()) {
        let urlString = baseURL + "/tasks" + "/\(id)"
        guard let url = URL(string: urlString) else {
            return
        }
        
        var requset = URLRequest(url: url)
        
        requset.addValue("application/json", forHTTPHeaderField: "Content-Type")
        requset.httpMethod = "DELETE"
                
        URLSession.shared.dataTask(with: requset) { data, response, error in
            guard self.checkValidation(data: data, response: response, error: error) else {
                completion(false)
                return
            }
            completion(true)
        }.resume()
    }
}
