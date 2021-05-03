//
//  MovieList.swift
//  InfoMovies
//
//  Created by Robin Singh on 14/04/21.
//

import Foundation

class MovieList: Decodable {
    let Search: [MovieInBrief]
    let totalResults: String
}
