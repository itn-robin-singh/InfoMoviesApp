//
//  FavouriteListDataManager.swift
//  InfoMovies
//
//  Created by Robin Singh on 11/04/21.
//

import Foundation
import UIKit

class FavouriteListDataManager {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var favouriteMovieList: [FavouriteMovie] = []
    
    static let sharedObject: FavouriteListDataManager = FavouriteListDataManager()
    
    var mappingOfIdWithMovie:[String: Bool] = [:]
    
    static func getObject() -> FavouriteListDataManager {
        return sharedObject
    }
    
    func initList() {
        let movies = try? context.fetch(FavouriteMovie.fetchRequest())
        favouriteMovieList = movies! as! [FavouriteMovie]
        for movie in favouriteMovieList {
            mappingOfIdWithMovie[movie.imdbId!] = true
        }
    }
    
    func getSize() -> Int {
        return favouriteMovieList.count
    }
    
    func isInFavouriteList(imdbId: String) -> Bool {
        if let _ = mappingOfIdWithMovie[imdbId] {
            return true
        }
        return false
    }
    
    func insertAMovie(imdbId: String,title: String,yearOfRelease: String,poster: Data) {
        
        if  isInFavouriteList(imdbId: imdbId) {
            return 
        }
        
        let newMovie = FavouriteMovie(context: context)
        newMovie.imdbId = imdbId
        newMovie.title = title
        newMovie.yearOfRelease = yearOfRelease
        newMovie.poster = poster
        
        mappingOfIdWithMovie[imdbId] = true
        
        favouriteMovieList.append(newMovie)
        
        print("movie inserted successfully")
        
        do {
            try context.save()
        }catch {
            print("Creating of movie with id \(imdbId) not possible!!")
        }
        
    }
    
    func deleteAMovie(imdbId: String) {
        
        for index in 0..<favouriteMovieList.count {
            if favouriteMovieList[index].imdbId == imdbId {
                context.delete(favouriteMovieList[index])
                favouriteMovieList.remove(at: index)
                break
            }
        }
        
        mappingOfIdWithMovie.removeValue(forKey: imdbId)
        
        print("Deletion successfull")
        
        do{
            try context.save()
        }catch {
            print("Deleting of movie with id \(imdbId) not possible!!")
        }
    }
    
}
