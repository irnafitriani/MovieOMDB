//
//  API.swift
//  MovieOMDB
//
//  Created by irna on 12/9/18.
//  Copyright © 2018 irna. All rights reserved.
//

import Foundation
import Moya
import CoreData

class API {
    
    static let apiKey = "24c0ccb1"
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    static let provider = MoyaProvider<MovieApi>(plugins: [NetworkLoggerPlugin(verbose: true)]) // for development
    
    static func searchByTitle(title: String, page: Int, completion: @escaping(Movie) -> ()) {
        provider.request(.searchByTitle(title: title, page: page)) { result in
            
            switch result {
            case let .success(response):
                do {
                    
                    if let json = try JSONSerialization.jsonObject(with: response.data, options: [.mutableContainers]) as? [String: AnyObject] {
                        guard let itemsJsonArray = json["movies"] as? [[String: AnyObject]] else {
                            return
                        }
                        DispatchQueue.main.async {
//                            completion((itemsJsonArray))
                        }
                    }
//                    guard let data = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String : Any]
//                    else{return}
//
//                    guard let movie = createMovieEntityFrom(dictionary: data) else {return}
//                    completion(movie)
                    
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    
    // Add to Movie Entity
    static private func createMovieEntityFrom(dictionary: [String: Any]) -> Movie? {
        let context = appDelegate.persistentContainer.viewContext
        if let movieEntity = NSEntityDescription.insertNewObject(forEntityName: "Movie", into: context) as? Movie {
            movieEntity.actor = dictionary ["Actor"] as? String
            movieEntity.awards = dictionary ["Awards"] as? String
            movieEntity.boxOffice = dictionary ["BoxOffice"] as? String
            movieEntity.country = dictionary ["Country"] as? String
            movieEntity.director = dictionary ["director"] as? String
            movieEntity.dvd = dictionary ["DVD"] as? String
            movieEntity.genre = dictionary ["Genre"] as? String
            movieEntity.imdbID = dictionary ["imdbID"] as? String
            movieEntity.imdbRating = dictionary ["imdbRating"] as? String
            movieEntity.imdbVotes = dictionary ["imdbVotes"] as? String
            movieEntity.language = dictionary ["Language"] as? String
            movieEntity.metascore = dictionary ["Metascore"] as? String
            movieEntity.plot = dictionary ["Plot"] as? String
            movieEntity.poster = dictionary ["Poster"] as? String
            movieEntity.production = dictionary ["Production"] as? String
            movieEntity.rated = dictionary ["Rated"] as? String
            movieEntity.released = dictionary ["Released"] as? String
            movieEntity.response = dictionary ["Response"] as? String
            movieEntity.runtime = dictionary ["Runtime"] as? String
            movieEntity.title = dictionary ["Title"] as? String
            movieEntity.type = dictionary ["Type"] as? String
            movieEntity.website = dictionary ["Website"] as? String
            movieEntity.writer = dictionary ["Writer"] as? String
            movieEntity.year = dictionary ["Year"] as? String
            
            guard let ratings = dictionary ["Ratings"] as? [[String : String]] else {return Movie()}
    
            for rate in ratings{
                guard let rating = NSEntityDescription.insertNewObject(forEntityName: "Rating", into: context) as? Rating else {return nil}
                rating.source = rate["Source"]
                rating.value = rate["Value"]
                movieEntity.addToRatings(rating)
            }
            
            return movieEntity
        }
        return nil
    }
}
