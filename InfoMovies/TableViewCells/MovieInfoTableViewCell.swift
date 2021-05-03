//
//  MovieInfoTableViewCell.swift
//  InfoMovies
//
//  Created by Robin Singh on 08/04/21.
//

import UIKit

class MovieInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var MovieInfoLabel: UILabel!
    
    static let identifier = "movieInfoCell"
    
    static func getNib() -> UINib {
        return UINib(nibName: "MovieInfoTableViewCell", bundle: nil)
    }
    
    func configCell(_ value: String) {
        MovieInfoLabel.text = value
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
