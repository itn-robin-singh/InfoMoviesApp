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

class Error: Decodable {
    let Error: String
}

protocol DataManagerDelegate {
    func initMovieTable(_: [MovieInBrief],_:[MoviesPoster])
    func updateMovieList(_: [MovieInBrief],_:[MoviesPoster])
    func showError(error: String)
}


class BriefInfoDataManager {
    
    private let baseUrl = "https://www.omdbapi.com/?apikey=66cc1950"
    
    private var currentUrl: String = ""
    
    var delegate: DataManagerDelegate?
    
    private var moviesPoster: [MoviesPoster] = []
    private var moviesList: [MovieInBrief] = []
    
    private var currentIndex = 0
    private var endingIndex = 0
    private var currentPage = 1
    
    private let cacheImage = CachImages()
    
    var fetchingData = false
    
    func reset() {
        currentIndex = 0
        endingIndex = 0
        currentPage = 1
        moviesPoster = []
        moviesList = []
    }
    
    func fetchMovieListFromAPI(ofMovie movieName: String) {
        
        self.fetchingData = true
        
        currentUrl = baseUrl + "&s=%22\(movieName.replacingOccurrences(of: " ", with: "%20"))%22&page=\(currentPage)"
        
        let dataTask = URLSession.shared.dataTask(with: URL(string: currentUrl)!) { (data, urlResponse, error) in
            
            guard error == nil else {
                print("Some Error occured while fetching the data from API!")
                return
            }
            
            let responseObj = try! JSONDecoder().decode(Response.self, from: data!)

            if responseObj.Response == "False" {
                print("No more data")
                if self.currentPage == 1 {
                    let errorObject = try! JSONDecoder().decode(Error.self, from: data!)
                    self.delegate?.showError(error: errorObject.Error)
                }
                return
            }
            
            let moviesListObj = try? JSONDecoder().decode(MovieList.self, from: data!)
            
            if moviesListObj == nil {
                print("found nil")
                return
            }
            for movie in moviesListObj!.Search {
                self.moviesList.append(movie)
            }
            print("Movies List fetched")
            self.fetchMoviePoster()
        }
        dataTask.resume()
    }
    
    // 1 2 3 4
    
    func fetchMoviePoster() {
        currentIndex = endingIndex
        endingIndex =  moviesList.count
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
            print("image fetching done for page \(currentPage)")
            currentPage += 1
            self.fetchingData = false
            return
        }
        
        print("Current Index: \(currentIndex)   Movie List Size: \(moviesList.count) Ending Index: \(endingIndex)")
        
        if moviesList[currentIndex].Poster == "N/A" {
            self.moviesPoster.append(MoviesPoster())
            self.currentIndex += 1
            self.fetchMoviePosterFromAPI()
            return
        }
        
        if let posterImage = cacheImage.getImage(for: moviesList[self.currentIndex].imdbID) {
            self.moviesPoster.append(MoviesPoster(image: posterImage))
            currentIndex += 1
            self.fetchMoviePosterFromAPI()
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: URL(string: moviesList[currentIndex].Poster)!) { (data, urlResponse, error) in
            guard error == nil else {
                print("Some Error occured while fetching the data from API!")
                return
            }
            self.moviesPoster.append(MoviesPoster(data: data!))
            self.cacheImage.insertImage(UIImage(data: data!)!, for: self.moviesList[self.currentIndex].imdbID)
            self.currentIndex += 1
            self.fetchMoviePosterFromAPI()
        }
        dataTask.resume()
    }
    
}
