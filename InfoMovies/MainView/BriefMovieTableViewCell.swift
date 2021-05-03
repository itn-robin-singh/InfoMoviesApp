//
//  BriefMovieTableViewCell.swift
//  InfoMovies
//
//  Created by Robin Singh on 06/04/21.
//

import UIKit

class BriefMovieTableViewCell: UITableViewCell {
    
    static let identifier = "briefCell"
    
    static func getNib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
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
