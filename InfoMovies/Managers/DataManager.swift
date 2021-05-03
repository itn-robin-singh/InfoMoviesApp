//
//  DataManager.swift
//  InfoMovies
//
//  Created by Robin Singh on 05/04/21.
//

import Foundation
import UIKit

class Response: Decodable {
    let Response: String
}

class MovieInBrief: Decodable {
    /*
     {
     Title: "The Avengers Lego Adventure",
     Year: "2013",
     imdbID: "tt4070086",
     Type: "movie",
     Poster: "https://m.media-amazon.com/images/M/MV5BNjZjMTlhMjctMzZjYy00YjJkLWFjMmItYTE1ZWRlNjIxOWY2XkEyXkFqcGdeQXVyNTY2MzQ3MDE@._V1_SX300.jpg"
     }
    */
    let Title: String
    let Year: String
    let imdbID: String
    let `Type`: String
    let Poster: String
}

class MovieList: Decodable {
    let Search: [MovieInBrief]
    let totalResults: String
}

protocol DataManagerDelegate {
    func initMovieTable(_: [MovieInBrief],_:[MoviesPoster])
    func updateMovieList(_: [MovieInBrief],_:[MoviesPoster])
}

class MoviesPoster {
    var Poster: UIImage
    init(data: Data) {
        Poster = UIImage(data: data)!
    }
    init() {
        Poster = UIImage(systemName: "gear")!
    }
}

class BriefInfoDataManager {
    
    let baseUrl = "https://www.omdbapi.com/?apikey=66cc1950"
    
    var currentUrl: String = ""
    
    var delegate: DataManagerDelegate?
    
    var moviesPoster: [MoviesPoster] = []
    var moviesList: [MovieInBrief] = []
    
    var currentIndex = 0
    var endingIndex = 0
    var currentPage = 1
    
    func reset() {
        currentIndex = 0
        endingIndex = 0
        currentPage = 1
    }
    
    func fetchMovieListFromAPI(ofMovie movieName: String) {
        
        moviesPoster = []
        
        moviesList = []
        
        currentUrl = baseUrl + "&s=%22\(movieName.replacingOccurrences(of: " ", with: "%20"))%22&page=\(currentPage)"

        let dataTask = URLSession.shared.dataTask(with: URL(string: currentUrl)!) { (data, urlResponse, error) in
            guard error == nil else {
                print("Some Error occured while fetching the data from API!")
                return
            }
            
            let responseObj = try! JSONDecoder().decode(Response.self, from: data!)
            
            if responseObj.Response == "False" {
                return
            }
            
            let moviesListObj = try? JSONDecoder().decode(MovieList.self, from: data!)
            
            if moviesListObj == nil {
                print("found nil")
                return
            }
            self.moviesList = moviesListObj!.Search
            print("Movies List fetched")
            self.fetchMoviePoster()
        }
        dataTask.resume()
    }
    
    func fetchMoviePoster() {
        currentIndex = moviesPoster.count
        endingIndex = currentIndex + moviesList.count
        print("current index intialized")
        fetchMoviePosterFromAPI()
    }
    
    //use recursion to do syncronization
    func fetchMoviePosterFromAPI() {
        if currentIndex == endingIndex {
            if currentPage == 1{
                delegate?.initMovieTable(moviesList, moviesPoster)
            }else{
                delegate?.updateMovieList(moviesList,moviesPoster)
            }
            currentPage += 1
            return
        }
        if moviesList[currentIndex].Poster == "N/A" {
            self.moviesPoster.append(MoviesPoster())
            self.currentIndex += 1
            self.fetchMoviePosterFromAPI()
            return
        }
        let dataTask = URLSession.shared.dataTask(with: URL(string: moviesList[currentIndex].Poster)!) { (data, urlResponse, error) in
            guard error == nil else {
                print("Some Error occured while fetching the data from API!")
                return
            }
            self.moviesPoster.append(MoviesPoster(data: data!))
            self.currentIndex += 1
            self.fetchMoviePosterFromAPI()
        }
        dataTask.resume()
    }
    
    
    
}
