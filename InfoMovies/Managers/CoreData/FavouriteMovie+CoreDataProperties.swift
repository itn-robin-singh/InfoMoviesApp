//
//  FavouriteMovie+CoreDataProperties.swift
//  InfoMovies
//
//  Created by Robin Singh on 11/04/21.
//
//

import Foundation
import CoreData


extension FavouriteMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouriteMovie> {
        return NSFetchRequest<FavouriteMovie>(entityName: "FavouriteMovie")
    }

    @NSManaged public var imdbId: String?
    @NSManaged public var title: String?
    @NSManaged public var poster: Data?
    @NSManaged public var yearOfRelease: String?

}

extension FavouriteMovie : Identifiable {

}
