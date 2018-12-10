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
    case searchByTitle(title: String)
    case searchById(id: String)
    case searchMovies(searchText: String, page: Int)
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
        case .searchById, .searchByTitle, .searchMovies:
            return .get
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .searchById, .searchByTitle, .searchMovies:
            return URLEncoding.queryString
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .searchByTitle(let title):
            return ["t" : title, "apikey": API.apiKey]
        case .searchById(let id):
            return ["i" : id, "apikey" : API.apiKey]
        case .searchMovies(let searchText, let page):
            return ["s" : searchText, "apikey": API.apiKey, "page" : page]
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .searchByTitle, .searchById, .searchMovies:
            return .requestParameters(parameters: parameters!, encoding: parameterEncoding)
        }
    }
    
    var headers: [String : String]? {
        return [String : String]()
    }
}
