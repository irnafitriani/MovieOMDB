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
    
    static func searchMovies(searchText: String, page: Int, completion: @escaping(MovieSearch) -> ()){
        provider.request(.searchMovies(searchText: searchText, page: page)) { results in
            switch results {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(MovieSearch.self, from: response.data)
                    completion(results)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    
    static func searchByTitle(title: String, completion: @escaping(Movie) -> ()) {
        provider.request(.searchByTitle(title: title)) { result in
            
            switch result {
            case let .success(response):
                do {
                    
                    guard let data = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String : Any]
                    else{return}
                    
                    let imdbId = data ["imdbID"] as! String
                    var movie : Movie!
                    
                    if !isMovieExists(id: imdbId){
                        movie = createMovieEntityFrom(dictionary: data)

                    }
                    movie = fetchMovieDetail(id: imdbId)
                    
                    completion(movie)

                    
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    
    //Check data is Exist
    static private func isMovieExists(id: String) -> Bool {
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        fetchRequest.predicate = NSPredicate(format: "imdbID = %@", id)
        fetchRequest.returnsObjectsAsFaults = false
        var entitiesCount = 0
        
        do {
            entitiesCount = try context.count(for: fetchRequest)
        }
        catch {
            print("error executing fetch request: \(error)")
        }
        
        return entitiesCount > 0
    }
    
    static private func fetchMovieDetail(id: String) -> Movie {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        request.predicate = NSPredicate(format: "imdbID = %@", id)
        request.returnsObjectsAsFaults = false
        var arrayMovie = [Movie]()
        do {
            let result = try context.fetch(request)
            for data in result as! [Movie] {
                print(data.value(forKey: "title") as! String)
                arrayMovie.append(data)
            }
            
        } catch {
            
            print("Failed")
        }
        
        if arrayMovie.count > 0 {
            return arrayMovie.first!
        }
        
        return Movie()

    }
    
    
    // Add to Movie Entity
    static private func createMovieEntityFrom(dictionary: [String: Any]) -> Movie? {
        let context = appDelegate.persistentContainer.viewContext
        if let movieEntity = NSEntityDescription.insertNewObject(forEntityName: "Movie", into: context) as? Movie {
            movieEntity.actor = dictionary ["Actors"] as? String
            movieEntity.awards = dictionary ["Awards"] as? String
            movieEntity.boxOffice = dictionary ["BoxOffice"] as? String
            movieEntity.country = dictionary ["Country"] as? String
            movieEntity.director = dictionary ["Director"] as? String
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
