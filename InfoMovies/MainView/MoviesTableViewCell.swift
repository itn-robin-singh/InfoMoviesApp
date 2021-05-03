//
//  MoviesTableViewCell.swift
//  InfoMovies
//
//  Created by Robin Singh on 05/04/21.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleOftheMovie: UILabel!
    @IBOutlet weak var yearOfRelease: UILabel!
    @IBOutlet weak var typeOfMovie: UILabel!
    
    static let identifier = "MoviesTableViewCell"
    
    static func getNib() -> UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func updateValuesInTheCell(movieImage image: UIImage,titleOfTheMovie movieTitle: String,yearOfRelease: String,typeOfMovie movieType: String){
        self.posterImage.image = image
        self.titleOftheMovie.text = movieTitle
        self.yearOfRelease.text = yearOfRelease
        self.typeOfMovie.text = movieType
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
