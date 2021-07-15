//
//  RequestType.swift
//  ProjectManager
//
//  Created by 강경 on 2021/07/15.
//

import Foundation

enum RequestType {
    case loadPage(_ type: TableViewType, _ page: Int)
    case postProduct
    case patchProduct(id: Int)
    case deleteProduct(id: Int)
    
    static let successStatusCode: ClosedRange<Int> = (200...299)
    static let baseURL: String = "https://yagom-project-manager.herokuapp.com"
    private var urlPath: String {
        switch self {
        case .loadPage(let type, let page):
            return "/memo/\(type)?/page=\(page)&per=10&sort-order=ascending"
        case .postProduct:
            return "/memo"
        case .patchProduct(let id):
            return "/memo/\(id)"
        case .deleteProduct(let id):
            return "/memo/\(id)"
        }
    }
    
    var url: URL? {
        return URL(string: "\(RequestType.baseURL)\(urlPath)")
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case .loadPage:
            return .get
        case .postProduct:
            return .post
        case .patchProduct:
            return .patch
        case .deleteProduct:
            return .delete
        }
    }
}
