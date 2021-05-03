//
//  Sampledata+CoreDataProperties.swift
//  InfoMovies
//
//  Created by Robin Singh on 10/04/21.
//
//

import Foundation
import CoreData


extension Sampledata {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sampledata> {
        return NSFetchRequest<Sampledata>(entityName: "Sampledata")
    }

    @NSManaged public var name: String?

}

extension Sampledata : Identifiable {

}
