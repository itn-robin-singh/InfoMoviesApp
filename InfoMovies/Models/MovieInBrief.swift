//
//  MovieInBrief.swift
//  InfoMovies
//
//  Created by Robin Singh on 14/04/21.
//

import Foundation

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
    var Title: String
    var Year: String
    var imdbID: String
    var `Type`: String
    var Poster: String
}
