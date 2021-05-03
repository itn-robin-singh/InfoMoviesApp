//
//  ErrorUITableViewCell.swift
//  InfoMovies
//
//  Created by Robin Singh on 12/04/21.
//

import UIKit

class ErrorUITableViewCell: UITableViewCell {
    
    static let identifer = "errorCell"
    @IBOutlet weak var errorLabel: UILabel!
    
    static func getNib() -> UINib {
        return UINib(nibName: "ErrorUITableViewCell", bundle: nil)
    }
    
    func config(error:String) {
        errorLabel.text = error
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
