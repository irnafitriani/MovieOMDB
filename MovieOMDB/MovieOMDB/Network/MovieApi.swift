//
//  MovieApi.swift
//  MovieOMDB
//
//  Created by irna on 12/9/18.
//  Copyright © 2018 irna. All rights reserved.
//

import Foundation
import Moya

enum MovieApi {
    case searchByTitle(title: String, page: Int)
    case searchById(id: String)
}

extension MovieApi: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "http://www.omdbapi.com/") else { fatalError("baseURL could not be configured") }
        return url
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        switch self {
        case .searchById, .searchByTitle:
            return .get
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .searchById, .searchByTitle:
            return URLEncoding.queryString
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .searchByTitle(let title, let page):
            return ["s" : title, "apikey": API.apiKey, "page" : page]
        case .searchById(let id):
            return ["i" : id, "apikey" : API.apiKey]
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .searchByTitle, .searchById:
            return .requestParameters(parameters: parameters!, encoding: parameterEncoding)
        }
    }
    
    var headers: [String : String]? {
        return [String : String]()
    }
}
