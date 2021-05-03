//
//  MovieImageTableViewCell.swift
//  InfoMovies
//
//  Created by Robin Singh on 07/04/21.
//

import UIKit

class MovieImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    static var identifier = "movieImageCell"
    
    static func getNib() -> UINib {
        return UINib(nibName: "MovieImageTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(moviePosterImage: UIImage) {
        posterImage.image = moviePosterImage
        posterImage.contentMode = .scaleAspectFit
    }
    
}
