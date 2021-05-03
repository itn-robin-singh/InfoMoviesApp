//
//  MoviesPoster.swift
//  InfoMovies
//
//  Created by Robin Singh on 14/04/21.
//

import Foundation
import UIKit

class MoviesPoster {
    var Poster: UIImage
    init(data: Data) {
        if let temp = UIImage(data: data) {
            Poster = temp
        }else {
            Poster = UIImage(named: "noImage")!
        }
    }
    init() {
        Poster = UIImage(named: "noImage")!
    }
    init(image: UIImage) {
        Poster = image
    }
}
