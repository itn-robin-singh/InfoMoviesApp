//
//  MovieTableViewCell.swift
//  InfoMovies
//
//  Created by Robin Singh on 06/04/21.
//

import UIKit

protocol MovieTableViewCellDelegateForFavourite {
    func addMovieToFavouriteList(imdbID: String,poster: UIImage,year: String, title: String)
    func removeMovieFromFavouriteList(imdbId: String)
}

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var titleOfMovie: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var typeOfMovie: UILabel!
    @IBOutlet weak var favroiteButton: UIButton!
    
    static let identifier = "movieCell"
    
    var favouriteMovieDelegate: MovieTableViewCellDelegateForFavourite? = nil
    
    private var idOfTheCell = ""
    
    static func getNib() -> UINib {
        return UINib(nibName: "MovieTableViewCell", bundle: nil)
    }
    
    func config(title: String,yearOfRelease: String,type: String,poster: UIImage,idOfTheCell: String) {
        titleOfMovie.text = "\(title)"
        year.text = "Year: \(yearOfRelease)"
        typeOfMovie.text = "Type: \(type)"
        moviePoster.contentMode = .scaleAspectFit
        moviePoster.image = poster
        self.idOfTheCell = idOfTheCell

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addMovieToFavroite(_ sender: Any) {
        let button = sender as! UIButton
        print("button pressed")
        let textOnButton = button.titleLabel?.text ?? "Nothing"
        if textOnButton == "Remove" {
            print("remove")
            favouriteMovieDelegate?.removeMovieFromFavouriteList(imdbId: idOfTheCell)
        }else{
            favouriteMovieDelegate?.addMovieToFavouriteList(
                imdbID: idOfTheCell,
                poster: moviePoster.image!,
                year: year.text!,
                title: titleOfMovie.text!
            )
        }
    }
}
