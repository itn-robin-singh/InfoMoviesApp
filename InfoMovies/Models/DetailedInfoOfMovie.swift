//
//  DetailedInfoOfMovie.swift
//  InfoMovies
//
//  Created by Robin Singh on 14/04/21.
//

import Foundation

class RatingInfo: Decodable {
    /*
     {
     Source: "Internet Movie Database",
     Value: "4.4/10"
     }
     */
    let Source: String
    let Value: String
}

class DetailedInfoOfMovie: Decodable{
    /*
     {
     Title: "Weapon",
     Year: "1997",
     Rated: "N/A",
     Released: "28 Feb 1997",
     Runtime: "127 min",
     Genre: "Action, Drama, Musical, Thriller",
     Director: "Sohail Khan",
     Writer: "Anwar Khan",
     Actors: "Salman Khan, Sanjay Kapoor, Shilpa Shetty Kundra, Nirmal Pandey",
     Plot: "Two college friends find themselves on the opposite side of the law when they reunite.",
     Language: "Hindi",
     Country: "India",
     Awards: "N/A",
     Poster: "https://m.media-amazon.com/images/M/MV5BMTQ1Nzg4NDUwNF5BMl5BanBnXkFtZTcwODI5ODQyMQ@@._V1_SX300.jpg",
     Ratings: [
     {
     Source: "Internet Movie Database",
     Value: "4.4/10"
     },
     {
     Source: "Rotten Tomatoes",
     Value: "25%"
     }
     ],
     Metascore: "N/A",
     imdbRating: "4.4",
     imdbVotes: "921",
     imdbID: "tt0118660",
     Type: "movie",
     DVD: "18 Sep 2020",
     BoxOffice: "N/A",
     Production: "N/A",
     Website: "N/A",
     Response: "True"
     }
     */
    let Title: String
    let Year: String
    let Rated: String
    let Released: String
    let Runtime: String
    let Genre: String
    let Director: String
    let Writer: String
    let Actors: String
    let Plot: String
    let Language: String
    let Country: String
    let Awards: String
    let Poster: String
//    let Ratings: [RatingInfo]
    let Metascore: String
    let imdbRating: String
    let imdbVotes: String
    let imdbID: String
    let `Type`: String
//    let DVD: String
//    let BoxOffice: String
//    let Production: String
//    let Website: String
}
