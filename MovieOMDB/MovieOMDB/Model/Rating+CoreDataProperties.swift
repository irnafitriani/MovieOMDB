//
//  Rating+CoreDataProperties.swift
//  MovieOMDB
//
//  Created by irna on 12/9/18.
//  Copyright © 2018 irna. All rights reserved.
//
//

import Foundation
import CoreData


extension Rating {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Rating> {
        return NSFetchRequest<Rating>(entityName: "Rating")
    }

    @NSManaged public var source: String?
    @NSManaged public var value: String?
    @NSManaged public var movie: Movie?

}
