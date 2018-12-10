//
//  Movie+CoreDataProperties.swift
//  MovieOMDB
//
//  Created by irna on 12/9/18.
//  Copyright © 2018 irna. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var year: String?
    @NSManaged public var rated: String?
    @NSManaged public var runtime: String?
    @NSManaged public var released: String?
    @NSManaged public var genre: String?
    @NSManaged public var director: String?
    @NSManaged public var writer: String?
    @NSManaged public var actor: String?
    @NSManaged public var plot: String?
    @NSManaged public var language: String?
    @NSManaged public var country: String?
    @NSManaged public var awards: String?
    @NSManaged public var poster: String?
    @NSManaged public var metascore: String?
    @NSManaged public var imdbRating: String?
    @NSManaged public var imdbVotes: String?
    @NSManaged public var imdbID: String?
    @NSManaged public var type: String?
    @NSManaged public var dvd: String?
    @NSManaged public var boxOffice: String?
    @NSManaged public var production: String?
    @NSManaged public var website: String?
    @NSManaged public var response: String?
    @NSManaged public var ratings: NSSet?

}

// MARK: Generated accessors for ratings
extension Movie {

    @objc(addRatingsObject:)
    @NSManaged public func addToRatings(_ value: Rating)

    @objc(removeRatingsObject:)
    @NSManaged public func removeFromRatings(_ value: Rating)

    @objc(addRatings:)
    @NSManaged public func addToRatings(_ values: NSSet)

    @objc(removeRatings:)
    @NSManaged public func removeFromRatings(_ values: NSSet)

}
