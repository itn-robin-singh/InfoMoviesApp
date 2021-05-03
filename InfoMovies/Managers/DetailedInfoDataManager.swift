//
//  DetailInfoDataManager.swift
//  InfoMovies
//
//  Created by Robin Singh on 07/04/21.
//

import Foundation


protocol DetailInfoDataManagerDelegate {
    func updateTheDetailTable(_: DetailedInfoOfMovie,_:Data?)
}

class DetailedInfoDataManager {
    
    let baseURL = "https://www.omdbapi.com/?apikey=66cc1950&i="
    
    var delegate :DetailInfoDataManagerDelegate? = nil
    
    func fetchDetailedMovieData(_ imdbID: String) {
        URLSession.shared.dataTask(with: URL(string: baseURL + imdbID)!, completionHandler: { (data, URLresponse, error) in
            guard error == nil else {
                print("An error occured during fetching the data from the API")
                return
            }
            let detailOfMovie = try? JSONDecoder().decode(DetailedInfoOfMovie.self, from: data!)
            
            guard detailOfMovie != nil else {
                print("Something Wrong with JSON Parser")
                return
            }
            
            print("Details of the movie are fetched")
            
            if detailOfMovie?.Poster != "N/A" {
                self.fetchCurrentMovieImage(detailOfMovie!)
            }else {
                self.delegate?.updateTheDetailTable(detailOfMovie!, nil)
            }
            
        }).resume()
    }
    
    func fetchCurrentMovieImage(_ movieDetails: DetailedInfoOfMovie) {
        URLSession.shared.dataTask(
            with: URL(string: movieDetails.Poster)!,
            completionHandler: { (data, URLResponse, error) in
            guard error == nil else {
                print("Some error occured while fetching the movie image from the API")
                return
            }
            print("Poster Imaged fetched")
            self.delegate?.updateTheDetailTable(movieDetails, data)
        }).resume()
    }
    
}
