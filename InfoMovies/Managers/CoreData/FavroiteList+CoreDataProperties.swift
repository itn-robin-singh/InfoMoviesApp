//
//  FavroiteList+CoreDataProperties.swift
//  InfoMovies
//
//  Created by Robin Singh on 11/04/21.
//
//

import Foundation
import CoreData


extension FavroiteList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavroiteList> {
        return NSFetchRequest<FavroiteList>(entityName: "FavroiteList")
    }

    @NSManaged public var imdbId: String?
    @NSManaged public var titleOfMovie: String?
    @NSManaged public var posterOfMovie: Data?
    @NSManaged public var yearOfRelease: String?

}

extension FavroiteList : Identifiable {

}
