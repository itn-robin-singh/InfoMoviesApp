//
//  DetailViewController.swift
//  InfoMovies
//
//  Created by Robin Singh on 05/04/21.
//

import UIKit


class DetailViewController: UIViewController {
    @IBOutlet weak var movieDetailTableView: UITableView!
    
    var id = "tt0118660"
    var posterImage = UIImage(named: "noImage")!
    var movieTitle = ""
    
    var moviesList: [MovieInBrief] = []
    var moviesPosterList: [MoviesPoster] = []
    
    private var currentMovieInfo: DetailedInfoOfMovie? = nil
    
    private let detailedInfoDataManager = DetailedInfoDataManager()
    
    var comeFromFavourite = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieDetailTableView.register(
            MovieImageTableViewCell.getNib(),
            forCellReuseIdentifier: MovieImageTableViewCell.identifier
        )
        movieDetailTableView.register(
            MovieInfoTableViewCell.getNib(),
            forCellReuseIdentifier: MovieInfoTableViewCell.identifier
        )
        movieDetailTableView.register(MoreMoviesTableViewCell.getNib(), forCellReuseIdentifier: MoreMoviesTableViewCell.identifier)
        movieDetailTableView.delegate = self
        movieDetailTableView.dataSource = self
        detailedInfoDataManager.delegate = self
        detailedInfoDataManager.fetchDetailedMovieData(id)
    }
    
}

extension DetailViewController: DetailInfoDataManagerDelegate {
    func updateTheDetailTable(_ detailInfoObj: DetailedInfoOfMovie, _ imageInDataFormat: Data?) {
        if imageInDataFormat != nil {
            posterImage = UIImage(data: imageInDataFormat!)!
        }
        currentMovieInfo = detailInfoObj
        print("Poster image updated")
        DispatchQueue.main.async {
            self.movieDetailTableView.reloadData()
        }
    }
}

extension DetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        title = movieTitle
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieImageTableViewCell.identifier, for: indexPath) as! MovieImageTableViewCell
            cell.config(moviePosterImage: posterImage)
            return cell
        }
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieInfoTableViewCell.identifier, for: indexPath) as! MovieInfoTableViewCell
            cell.configCell(movieTitle)
            return cell
        }
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieInfoTableViewCell.identifier, for: indexPath) as! MovieInfoTableViewCell
            //set date of release
            if let currentObject = currentMovieInfo{
                cell.configCell("Date of Release: \(currentObject.Released)")
            }else{
                cell.configCell("Fetching Data Please Wait.....")
            }
            return cell
        }
        if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieInfoTableViewCell.identifier, for: indexPath) as! MovieInfoTableViewCell
            //set runtime
            if let currentObject = currentMovieInfo {
                cell.configCell("Runtime: \(currentObject.Runtime)")
            }else {
                cell.configCell("Fetching Data Please Wait.....")
            }
            return cell
        }
        if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieInfoTableViewCell.identifier, for: indexPath) as! MovieInfoTableViewCell
            if let currentObject = currentMovieInfo {
                cell.configCell("Director: \(currentObject.Director)")
            }else {
                cell.configCell("Fetching Data Please Wait.....")
            }
            return cell
        }
        if indexPath.row == 5 && comeFromFavourite == false{
            let cell = tableView.dequeueReusableCell(withIdentifier: MoreMoviesTableViewCell.identifier, for: indexPath) as! MoreMoviesTableViewCell
            cell.setDelegate(delgateOfController: self)
            cell.moviesList = []
            cell.moviesPosterList = []
            for index in 0..<moviesList.count {
                if moviesList[index].imdbID != id {
                    cell.moviesList.append(moviesList[index])
                    cell.moviesPosterList.append(moviesPosterList[index])
                }
            }
            cell.createRandomList()
            cell.moreMoviesCollectionView.reloadData()
            return cell
        }
        return UITableViewCell()
    }
    
    
}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 260
        }
        if indexPath.row == 5 {
            return 226
        }
        return 66
    }
}

extension DetailViewController: MoreMovieCollectionViewDelegate {
    
    func movieSelectedInMoreMovie(id: String, poster: UIImage, title: String) {
        self.id = id
        self.posterImage = poster
        self.movieTitle = title
        currentMovieInfo = nil
        detailedInfoDataManager.fetchDetailedMovieData(id)
        DispatchQueue.main.async {
            self.movieDetailTableView.reloadData()
        }
    }
    
}
