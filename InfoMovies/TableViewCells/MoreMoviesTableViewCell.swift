//
//  MoreMoviesTableViewCell.swift
//  InfoMovies
//
//  Created by Robin Singh on 08/04/21.
//

import UIKit

protocol MoreMovieCollectionViewDelegate {
    func movieSelectedInMoreMovie(id: String,poster: UIImage,title: String)
}

class MoreMoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var moreMoviesLabel: UILabel!
    @IBOutlet weak var moreMoviesCollectionView: UICollectionView!
    
    var moviesList: [MovieInBrief] = []
    var moviesPosterList: [MoviesPoster] = []
    private var randomInt: [Int] = []
    
    static let identifier = "moreMovieTableViewCell"
    
    static func getNib() -> UINib {
        return UINib(nibName: "MoreMoviesTableViewCell", bundle: nil)
    }
    
    var delegate: MoreMovieCollectionViewDelegate? = nil
    
    func setDelegate(delgateOfController: MoreMovieCollectionViewDelegate) {
        delegate = delgateOfController
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        moreMoviesCollectionView.register(MoreMoviesCollectionViewCell.getNib(), forCellWithReuseIdentifier: MoreMoviesCollectionViewCell.identifier)
        moreMoviesCollectionView.dataSource = self
        moreMoviesCollectionView.delegate = self
    }
    
    func createRandomList() {
        randomInt = []
        for index in 0..<moviesList.count {
            randomInt.append(index)
        }
        randomInt.shuffle()
    
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension MoreMoviesTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoreMoviesCollectionViewCell.identifier, for: indexPath) as! MoreMoviesCollectionViewCell
        cell.config(moviesPosterList[randomInt[indexPath.row]].Poster, moviesList[randomInt[indexPath.row]].Title)
        return cell
    }
    
    
}

extension MoreMoviesTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.movieSelectedInMoreMovie(id: moviesList[randomInt[indexPath.row]].imdbID, poster: moviesPosterList[randomInt[indexPath.row]].Poster, title: moviesList[randomInt[indexPath.row]].Title)
    }
}
