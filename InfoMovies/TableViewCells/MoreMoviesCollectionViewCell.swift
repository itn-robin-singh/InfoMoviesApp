//
//  MoreMoviesCollectionViewCell.swift
//  InfoMovies
//
//  Created by Robin Singh on 09/04/21.
//

import UIKit

class MoreMoviesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleOfTheMovie: UILabel!
    
    static let identifier = "MoreMoviesCollectionViewCell"
    
    static func getNib() -> UINib {
        return UINib(nibName: "MoreMoviesCollectionViewCell", bundle: nil)
    }
    
    func config(_ posterImage: UIImage,_ title: String) {
        self.posterImage.image = posterImage
        self.titleOfTheMovie.text = title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
