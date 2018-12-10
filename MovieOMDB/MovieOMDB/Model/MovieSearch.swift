//
//  MovieSearch.swift
//  MovieOMDB
//
//  Created by irna on 12/10/18.
//  Copyright © 2018 irna. All rights reserved.
//

import Foundation

struct MovieSearch: Decodable {
    let search: [Search]?
    let totalResults, response: String?
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}

struct Search: Codable {
    let title, year, imdbID: String?
    let type: TypeEnum?
    let poster: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}

enum TypeEnum: String, Codable {
    case movie = "movie"
    case series = "series"
}
